# ocaml-cordova-plugin-qrscanner

[![LGPL-v3 licensed](https://img.shields.io/badge/license-LGPLv3-blue.svg)](https://raw.githubusercontent.com/dannywillems/ocaml-cordova-plugin-qrscanner/master/LICENSE)
[![Build Status](https://travis-ci.org/dannywillems/ocaml-cordova-plugin-qrscanner.svg?branch=master)](https://travis-ci.org/dannywillems/ocaml-cordova-plugin-qrscanner)

**Currently iOS only.**

Binding to
[cordova-plugin-qrscanner](https://github.com/apache/cordova-plugin-qrscanner)

[Example
application](https://github.com/dannywillems/ocaml-cordova-plugin-qrscanner-example).

## What does cordova-plugin-qrscanner do ?

```
A fast, energy efficient, highly-configurable QR code scanner for Cordova apps.
```

Source: [cordova-plugin-qrscanner](https://github.com/apache/cordova-plugin-qrscanner)

## How to install and compile your project by using this plugin ?

Don't forget to switch to a compiler **>= 4.03.0**.
```Shell
opam switch 4.03.0
```

You can use opam by pinning the repository with
```Shell
opam pin add cordova-plugin-qrscanner https://github.com/dannywillems/ocaml-cordova-plugin-qrscanner.git
```

and to compile your project, use
```Shell
ocamlfind ocamlc -c -o [output_file] -package gen_js_api -package cordova-plugin-qrscanner [...] -linkpkg [other arguments]
```

Don't forget to install the cordova plugin qrscanner with
```Shell
cordova plugin add cordova-plugin-qrscanner
```

## How to use ?

* TODO
* See the official documentation
[cordova-plugin-qrscanner](https://github.com/apache/cordova-plugin-qrscanner)
