# ocaml-cordova-plugin-qrscanner

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

## How to use ?

* TODO
* See the official documentation
[cordova-plugin-qrscanner](https://github.com/apache/cordova-plugin-qrscanner)

## ! BE CAREFUL !

The device plugin creates a new object called *QRScanner*, but the object is
available when the *deviceready* event is handled.

We don't provide a *qrscanner* variable in this plugin (as said in the official
documentation on js_of_ocaml). If we did, *qrscanner* will be set to **undefined**
because the *QRScanner* javascript object doesn't exist when we create
the variable.

Instead, we provide a function *Qrscanner.t* of type unit -> QRScanner.qrscanner
Js.t which does the binding when you call it.
So, use

```OCaml
let on_device_ready _ =
  let qr = Qrscanner.t () in
  (* Some code *)

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
```
