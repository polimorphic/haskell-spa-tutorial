self: super: {
  todo-js = with self.haskell.packages.ghcjs810;
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
        cp -r $src/static $out/
        mv temp.js $out/static/all.js
      '';
    };

  haskell = super.haskell // {
    packages = super.haskell.packages // {
      ghc8107 = super.haskell.packages.ghc8107.override {
        overrides = import ./haskell/packages/ghc8107 self;
      };
      ghcjs810 = super.haskell.packages.ghcjs810.override {
        overrides = import ./haskell/packages/ghcjs810 self;
      };
    };
  };
}
