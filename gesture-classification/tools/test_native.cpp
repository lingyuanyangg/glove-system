// Official FluCoMa classifier algorithms, compiled outside Max/Live.
#include <flucoma/algorithms/public/MLP.hpp>
#include <flucoma/algorithms/public/SGD.hpp>
#include <flucoma/data/FluidDataSet.hpp>
#include <flucoma/algorithms/public/LabelSetEncoder.hpp>
#include <cmath>
#include <iostream>
#include <stdexcept>
#include <iomanip>
using namespace fluid;
using fluid::algorithm::MLP;
using fluid::algorithm::SGD;
using fluid::algorithm::LabelSetEncoder;
const char* labels[]={"open","fist","index","v","middle","ok","other"};
const double poses[7][5]={{0,0,0,0,0},{1,1,1,1,1},{1,1,1,0,1},{1,1,0,0,1},{1,1,0,1,1},{0,0,0,.75,.75},{.45,.45,.45,.45,.45}};
void require(bool b,const char* message){if(!b)throw std::runtime_error(message);}
double feature(int label,int j,int trial,int nin){int pose=nin==10?(label==36?6:j<5?label/6:label%6):label;double x=poses[pose][j%5]+.025*std::sin((trial+1)*(j+3)*1.17);return std::max(0.0,std::min(1.0,x));}
double checkClassifier(int nin){
 int classes=nin==10?37:7;std::vector<std::string> names;for(int k=0;k<classes;k++)names.push_back(nin==10?(k==36?"other":std::string(labels[k/6])+"__"+labels[k%6]):labels[k]);
 LabelSetEncoder encoder;FluidDataSet<std::string,std::string,1> set(1);
 for(int k=0;k<classes;k++){FluidTensor<std::string,1> s{names[k]};set.add(std::to_string(k),s);}encoder.fit(set);require(encoder.numLabels()==classes,"Encoder lost a label");
 FluidTensor<std::string,1> saved(classes);encoder.getLabels(saved);LabelSetEncoder restoredEncoder;restoredEncoder.init(saved);
 for(int k=0;k<classes;k++)require(encoder.encodeIndex(names[k])==restoredEncoder.encodeIndex(names[k]),"Encoder recall changed label order");
 MLP model;int hidden=nin==10?32:8;model.init(nin,classes,{hidden},3,1);
 for(int layer=0;layer<2;layer++){int rows=model.inputSize(layer),cols=model.outputSize(layer+1);RealMatrix w(rows,cols);RealVector b(cols);for(int i=0;i<rows;i++)for(int j=0;j<cols;j++)w(i,j)=.12*std::sin((i+1)*(j+1)+layer);b.fill(0);model.setParameters(layer,w,b,layer==0?3:1);}
 const int samples=classes*20,epochs=500;RealMatrix x(samples,nin),y(samples,classes);y.fill(0);
 for(int k=0;k<classes;k++)for(int t=0;t<20;t++){int row=k*20+t;for(int j=0;j<nin;j++)x(row,j)=feature(k,j,t,nin);encoder.encodeOneHot(names[k],y.row(row));}
 int chunk=std::max(1,std::min(10,32768/(samples*classes*hidden)));
 double error=0;for(int epoch=0;epoch<epochs;epoch+=chunk){SGD sgd;error=sgd.train(model,x,y,std::min(chunk,epochs-epoch),4,.01,.9,0);require(std::isfinite(error),"Native classification training loss is invalid");}
 int correct=0;for(int k=0;k<classes;k++)for(int t=100;t<120;t++){RealVector input(nin),output(classes);for(int j=0;j<nin;j++)input(j)=static_cast<float>(feature(k,j,t,nin));model.processFrame(input,output,0,2);if(encoder.decodeOneHot(output)==names[k])correct++;}
 require(correct>=samples*.95,"Native synthetic held-out classification fell below 95 percent");
 MLP restored;restored.init(nin,classes,{hidden},3,1);for(int layer=0;layer<2;layer++){RealMatrix w(model.inputSize(layer),model.outputSize(layer+1));RealVector b(model.outputSize(layer+1));fluid::index activation;model.getParameters(layer,w,b,activation);restored.setParameters(layer,w,b,activation);}restored.setTrained(true);
 for(int k=0;k<classes;k++){RealVector input(nin),a(classes),b(classes);for(int j=0;j<nin;j++)input(j)=feature(k,j,50,nin);model.processFrame(input,a,0,2);restored.processFrame(input,b,0,2);for(int j=0;j<classes;j++)require(std::abs(a(j)-b(j))<1e-12,"Native recalled classifier prediction differs");require(encoder.decodeOneHot(a)==restoredEncoder.decodeOneHot(b),"Recalled classifier label differs");}
 return correct/static_cast<double>(samples);
}
int main(){try{double one=checkClassifier(5),both=checkClassifier(10);std::cout<<std::setprecision(12)<<"{\"kind\":\"Official FluCoMa 1.0.9 MLP/SGD/LabelSetEncoder native algorithms; synthetic data only\",\"native_max_host_tested\":false,\"checks\":[{\"name\":\"Five-input, seven-label held-out synthetic classification\",\"accuracy\":"<<one<<",\"pass\":true},{\"name\":\"Ten-input, 36 ordered pairs plus Other held-out synthetic classification\",\"accuracy\":"<<both<<",\"pass\":true},{\"name\":\"Label order and restored matrix/bias predictions agree in both input modes\",\"pass\":true}]}\n";}catch(const std::exception& e){std::cerr<<e.what()<<'\n';return 1;}}
