#include <Module.h> // JAGS module base class
#include <distributions/Dzil.h> // zero inflated laplace class


namespace wiener { // module namespace


  class WIENERModule : public Module { // module class

  public:

    WIENERModule(); // constructor

    ~WIENERModule(); // destructor
  };


  // #####
  // (a) constructor and destructor functions go here
  // #####
  
}


wiener::WIENERModule _wiener_module;
