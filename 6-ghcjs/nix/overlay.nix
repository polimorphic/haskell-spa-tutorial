self: super: {
  todo-js = with self.haskell.packages.ghcjs86;
    super.stdenv.mkDerivation {
      name = "todo-js";
      inherit (todo) src;
      buildCommand = ''
        mkdir -p $out/static
        ${super.closurecompiler}/bin/closure-compiler \
          --compilation_level ADVANCED_OPTIMIZATIONS \
          --jscomp_off=checkVars \
          --externs=${todo}/bin/todo-js.jsexe/all.js.externs \
          ${todo}/bin/todo-js.jsexe/all.js > temp.js
        mv temp.js $out/static/all.js
      '';
    };

  haskell = super.haskell // {
    packages = super.haskell.packages // {
      ghc865 = super.haskell.packages.ghc865.override {
        overrides = import ./haskell/packages/ghc865 self;
      };
      ghc864 = super.haskell.packages.ghc864.override {
        overrides = selfGhc864: superGhc864: with super.haskell.lib; {
          happy = dontCheck (selfGhc864.callHackage "happy" "1.19.9" {});
          mkDerivation = args: superGhc864.mkDerivation (args // {
            enableLibraryProfiling = false;
            doCheck = false;
            doHaddock = false;
          });
        };
      };
      ghcjs86 = super.haskell.packages.ghcjs86.override {
        overrides = import ./haskell/packages/ghcjs86 self;
      };
    };
  };
}
