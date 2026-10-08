// Standalone verification of official FluCoMa core 1.0.9, not a Live/Max host test.
#include <flucoma/algorithms/public/MLP.hpp>
#include <flucoma/algorithms/public/SGD.hpp>
#include <cmath>
#include <iomanip>
#include <iostream>
#include <stdexcept>

using namespace fluid;
using fluid::algorithm::MLP;
using fluid::algorithm::SGD;

void require(bool condition, const char* message) {
  if (!condition) throw std::runtime_error(message);
}
void initialise(MLP& model, int nin, int nout, int activation = 3) {
  model.init(nin, nout, {16}, activation, 0);
  for (int layer = 0; layer < 2; ++layer) {
    int rows = static_cast<int>(model.inputSize(layer));
    int cols = static_cast<int>(model.outputSize(layer + 1));
    RealMatrix weights(rows, cols);
    RealVector biases(cols);
    for (int i = 0; i < rows; ++i)
      for (int j = 0; j < cols; ++j)
        weights(i,j) = 0.15 * std::sin((i+1)*(j+1)+layer);
    for (int j = 0; j < cols; ++j) biases(j) = 0.02 * std::cos(j);
    model.setParameters(layer, weights, biases, layer == 0 ? activation : 0);
  }
}
void checkActivationsAndRestore() {
  for (int activation = 0; activation < 4; ++activation) {
    MLP model;
    initialise(model, 5, 10, activation);
    RealVector x(5), native(10);
    for (int i=0;i<5;++i) x(i)=static_cast<float>(0.1*(i+1));
    model.processFrame(x, native, 0, 2);
    RealVector hidden(16);
    for (int j=0;j<16;++j) {
      double z=0.02*std::cos(j);
      for (int i=0;i<5;++i) z+=x(i)*0.15*std::sin((i+1)*(j+1));
      hidden(j)=activation==3?std::tanh(z):activation==2?std::max(0.0,z):activation==1?1/(1+std::exp(-z)):z;
    }
    for (int j=0;j<10;++j) {
      double z=0.02*std::cos(j);
      for(int i=0;i<16;++i) z+=hidden(i)*0.15*std::sin((i+1)*(j+1)+1);
      require(std::abs(z-native(j))<1e-12,"Native activation/matrix prediction differs");
    }
    MLP restored;
    restored.init(5,10,{16},activation,0);
    for(int layer=0;layer<2;++layer) {
      RealMatrix w(model.inputSize(layer),model.outputSize(layer+1));
      RealVector b(model.outputSize(layer+1));
      fluid::index act;
      model.getParameters(layer,w,b,act);
      restored.setParameters(layer,w,b,act);
    }
    restored.setTrained(true);
    RealVector reloaded(10);
    restored.processFrame(x,reloaded,0,2);
    for(int j=0;j<10;++j) require(std::abs(native(j)-reloaded(j))<1e-12,"Native weight restoration differs");
  }
}
double checkTraining(int nin, int nout, int samples, int epochs, bool accuracy) {
  MLP model;
  initialise(model,nin,nout);
  RealMatrix x(samples,nin),y(samples,nout),prediction(samples,nout);
  for(int i=0;i<samples;++i) {
    for(int j=0;j<nin;++j) x(i,j)=((i*13+j*17)%101)/100.0;
    for(int j=0;j<nout;++j) y(i,j)=0.2+0.6*x(i,j%nin);
  }
  const int chunk=std::max(1,std::min(10,32768/(samples*nout*16)));
  double best=1e9;
  SGD optimiser;
  for(int epoch=0;epoch<epochs;epoch+=chunk) {
    double error=optimiser.train(model,x,y,std::min(chunk,epochs-epoch),1,0.01,0.9,0);
    require(std::isfinite(error)&&error>=0,"Native training error is invalid");
    model.process(x,prediction,0,2);
    double measured=0;
    for(int i=0;i<samples;++i) for(int j=0;j<nout;++j) measured+=std::pow(y(i,j)-prediction(i,j),2);
    require(std::abs(error-measured/samples)<1e-8,"Native loss scaling differs");
    best=std::min(best,std::sqrt(error/nout));
  }
  require(model.trained(),"Native model is not marked trained");
  if(accuracy)require(best<0.08,"Native synthetic mapping did not converge");
  return best;
}
int main() {
  try {
    checkActivationsAndRestore();
    double single=checkTraining(5,10,32,800,true);
    double both=checkTraining(10,10,32,800,true);
    double wide=checkTraining(10,256,32,800,true);
    double boundary=checkTraining(10,256,512,10,false);
    std::cout<<std::setprecision(12)
      <<"{\"kind\":\"Official FluCoMa core 1.0.9 compiled and executed in a standalone C++ test\",\"native_max_host_tested\":false,\"checks\":["
      <<"{\"name\":\"Four native activations and saved matrix/bias restoration agree with independent calculation\",\"pass\":true},"
      <<"{\"name\":\"Native 5-to-10 synthetic training RMSE\",\"value\":"<<single<<",\"pass\":true},"
      <<"{\"name\":\"Native 10-to-10 synthetic training RMSE\",\"value\":"<<both<<",\"pass\":true},"
      <<"{\"name\":\"Native 10-to-256 synthetic training RMSE\",\"value\":"<<wide<<",\"pass\":true},"
      <<"{\"name\":\"512-example, 256-output training remains finite; short training RMSE\",\"value\":"<<boundary<<",\"pass\":true}]}\n";
  } catch(const std::exception& e) { std::cerr<<e.what()<<'\n';return 1; }
}
