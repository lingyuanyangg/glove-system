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
double feature(int label,int j,int trial){double x=poses[label][j%5]+.025*std::sin((trial+1)*(j+3)*1.17);return std::max(0.0,std::min(1.0,x));}
double checkClassifier(int nin){
 LabelSetEncoder encoder;FluidDataSet<std::string,std::string,1> set(1);
 for(int k=0;k<7;k++){FluidTensor<std::string,1> s{labels[k]};set.add(std::to_string(k),s);}encoder.fit(set);require(encoder.numLabels()==7,"Encoder lost a label");
 FluidTensor<std::string,1> saved(7);encoder.getLabels(saved);LabelSetEncoder restoredEncoder;restoredEncoder.init(saved);
 for(int k=0;k<7;k++)require(encoder.encodeIndex(labels[k])==restoredEncoder.encodeIndex(labels[k]),"Encoder recall changed label order");
 MLP model;int hidden=nin==10?16:8;model.init(nin,7,{hidden},3,1);
 for(int layer=0;layer<2;layer++){int rows=model.inputSize(layer),cols=model.outputSize(layer+1);RealMatrix w(rows,cols);RealVector b(cols);for(int i=0;i<rows;i++)for(int j=0;j<cols;j++)w(i,j)=.12*std::sin((i+1)*(j+1)+layer);b.fill(0);model.setParameters(layer,w,b,layer==0?3:1);}
 const int samples=140,epochs=500;RealMatrix x(samples,nin),y(samples,7);y.fill(0);
 for(int k=0;k<7;k++)for(int t=0;t<20;t++){int row=k*20+t;for(int j=0;j<nin;j++)x(row,j)=feature(k,j,t);encoder.encodeOneHot(labels[k],y.row(row));}
 int chunk=std::max(1,std::min(10,32768/(samples*7*16)));
 double error=0;for(int epoch=0;epoch<epochs;epoch+=chunk){SGD sgd;error=sgd.train(model,x,y,std::min(chunk,epochs-epoch),4,.01,.9,0);require(std::isfinite(error),"Native classification training loss is invalid");}
 int correct=0;for(int k=0;k<7;k++)for(int t=100;t<120;t++){RealVector input(nin),output(7);for(int j=0;j<nin;j++)input(j)=static_cast<float>(feature(k,j,t));model.processFrame(input,output,0,2);if(encoder.decodeOneHot(output)==labels[k])correct++;}
 require(correct>=133,"Native synthetic held-out classification fell below 95 percent");
 MLP restored;restored.init(nin,7,{hidden},3,1);for(int layer=0;layer<2;layer++){RealMatrix w(model.inputSize(layer),model.outputSize(layer+1));RealVector b(model.outputSize(layer+1));fluid::index activation;model.getParameters(layer,w,b,activation);restored.setParameters(layer,w,b,activation);}restored.setTrained(true);
 for(int k=0;k<7;k++){RealVector input(nin),a(7),b(7);for(int j=0;j<nin;j++)input(j)=poses[k][j%5];model.processFrame(input,a,0,2);restored.processFrame(input,b,0,2);for(int j=0;j<7;j++)require(std::abs(a(j)-b(j))<1e-12,"Native recalled classifier prediction differs");require(encoder.decodeOneHot(a)==restoredEncoder.decodeOneHot(b),"Recalled classifier label differs");}
 return correct/140.0;
}
int main(){try{double one=checkClassifier(5),both=checkClassifier(10);std::cout<<std::setprecision(12)<<"{\"kind\":\"Official FluCoMa 1.0.9 MLP/SGD/LabelSetEncoder native algorithms; synthetic data only\",\"native_max_host_tested\":false,\"checks\":[{\"name\":\"Five-input, seven-label held-out synthetic classification\",\"accuracy\":"<<one<<",\"pass\":true},{\"name\":\"Ten-input, seven-label held-out synthetic classification\",\"accuracy\":"<<both<<",\"pass\":true},{\"name\":\"Label order and restored matrix/bias predictions agree in both input modes\",\"pass\":true}]}\n";}catch(const std::exception& e){std::cerr<<e.what()<<'\n';return 1;}}
