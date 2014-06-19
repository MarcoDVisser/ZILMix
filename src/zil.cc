#include <Module.h> // JAGS module base class
#include <distributions/Dzil.h> // zero inflated laplace class


namespace zil { // module namespace


  class ZILModule : public Module { // module class

  public:

    ZILModule(); // constructor

    ~ZILModule(); // destructor
  };


  // #####
  // (a) constructor and destructor functions go here
  // #####
  
}


zil::ZILModule _zil_module;
