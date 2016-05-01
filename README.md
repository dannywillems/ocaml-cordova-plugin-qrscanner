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

## Repository branches and tags

We are migrating bindings from
[js_of_ocaml](https://github.com/ocsigen/js_of_ocaml) (low level bindings) to
[gen_js_api](https://github.com/lexifi/gen_js_api) (high level bindings).

The gen_js_api binding allows to use *pure* ocaml types (you don't have to use
the ## syntax from js_of_ocaml or Js.string type but only # and string type).

The js_of_ocaml version is available in the branch
[*js_of_ocaml*](https://github.com/dannywillems/ocaml-cordova-plugin-qrscanner/tree/js_of_ocaml)
but we **recommend** to use the gen_js_api version which is the master branch.

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

## ! BE CAREFUL !

The device plugin creates a new object called *QRScanner*, but the object is
available when the *deviceready* event is handled.

We provide a function *Cordova_qr_scanner.t* of type unit -> Cordova_qr_scanner.qr_scanner
which does the binding when you call it.
So, use (with js_of_ocaml)

```OCaml
let on_device_ready _ =
  let qr = Cordova_qr_scanner.t () in
  (* Some code *)

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
```
