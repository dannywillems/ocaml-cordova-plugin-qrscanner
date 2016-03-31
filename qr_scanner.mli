(* -------------------------------------------------------------------------- *)
(* Defines different error type corresponding the the name given in the official
 * documentation
 *)
type error_name

(* Get the code depending on the error_name *)
val error_name_to_code : error_name -> int

(* Get the error name depending on the code --> Useful for typed programming *)
val code_to_error_name : int -> error_name

(* Get the message corresponding to the error name *)
val error_name_to_msg : error_name -> string

(* Error javascript object, used by some callbacks in qr_scanner object *)
type error =
  < _message                        : Js.js_string Js.t Js.readonly_prop ;
    code                            : int Js.readonly_prop ;
    name                            : Js.js_string Js.t Js.readonly_prop
  > Js.t
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Status javascript object, used by some callbacks in qr_scanner object *)
type status =
  <
    authorized                      : bool Js.readonly_prop ;
    denied                          : bool Js.readonly_prop ;
    restricted                      : bool Js.readonly_prop ;
    prepared                        : bool Js.readonly_prop ;
    scanning                        : bool Js.readonly_prop ;
    previewing                      : bool Js.readonly_prop ;
    webviewBackgroundIsTransparent  : bool Js.readonly_prop ;
    lightEnabled                    : bool Js.readonly_prop ;
    canOpenSettings                 : bool Js.readonly_prop ;
    canEnableLight                  : bool Js.readonly_prop ;
    currentCamera                   : int Js.readonly_prop
  > Js.t
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Define the front and back camear with a sum type. Can be used for useCamera
 * method on qr_scanner object to type. Don't forget to use camera_to_int to
 * apply it to useCamera
 *)
type camera
val camera_to_int : camera -> int
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* qr_scanner javascript object
 * error in callbacks are of type error Js.opt because if everything went
 * right, error is set to null.
 *)
class type qr_scanner =
  object
    method prepare          :   (error Js.opt -> status -> unit) -> unit Js.meth
    method scan             :   (error Js.opt -> Js.js_string Js.t -> unit) -> unit Js.meth
    method cancelScan       :   (status -> unit) -> unit Js.meth
    method show             :   (status -> unit) -> unit Js.meth
    method hide             :   (status -> unit) -> unit Js.meth
    method enableLight      :   (error Js.opt -> status -> unit) -> unit Js.meth
    method disableLight     :   (error Js.opt -> status -> unit) -> unit Js.meth
    method useCamera        :   int -> (error Js.opt -> status -> unit) -> unit Js.meth
    method useFrontCamera   :   (error Js.opt -> status -> unit) -> unit Js.meth
    method useBackCamera    :   (error Js.opt -> status -> unit) -> unit Js.meth
    method pausePreview     :   (status -> unit) -> unit Js.meth
    method resumePreview    :   (status -> unit) -> unit Js.meth
    method openSettings     :   (error Js.opt -> status -> unit) -> unit Js.meth
    method getStatus        :   (status -> unit) -> unit Js.meth
    method destroy          :   (status -> unit) -> unit Js.meth
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val qr_scanner : unit -> qr_scanner Js.t
(* -------------------------------------------------------------------------- *)
