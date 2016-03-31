(* -------------------------------------------------------------------------- *)
(* Defines different error type corresponding the the name given in the official
 * documentation
 *)
type error_name =
  | Camera_access_denied
  | Unexpected_error
  | Camera_access_restricted
  | Back_camera_unavailable
  | Front_camera_unavailable
  | Camera_unavailable
  | Scan_canceled | Light_unavailable
  | Open_settings_unavailable

(* Get the code depending on the error_name *)
let error_name_to_code e =
  match e with
  | Unexpected_error          -> 0
  | Camera_access_denied      -> 1
  | Camera_access_restricted  -> 2
  | Back_camera_unavailable   -> 3
  | Front_camera_unavailable  -> 4
  | Camera_unavailable        -> 5
  | Scan_canceled             -> 6
  | Light_unavailable         -> 7
  | Open_settings_unavailable -> 8

(* Get the error name depending on the code --> Useful for typed programming *)
let code_to_error_name e =
  match e with
  | 1 -> Camera_access_denied
  | 2 -> Camera_access_restricted
  | 3 -> Back_camera_unavailable
  | 4 -> Front_camera_unavailable
  | 5 -> Camera_unavailable
  | 6 -> Scan_canceled
  | 7 -> Light_unavailable
  | 8 -> Open_settings_unavailable
  | _ -> Unexpected_error

(* Get the message corresponding to the error name *)
let error_name_to_msg e =
  match e with
  | Unexpected_error          -> "Unexpected error"
  | Camera_access_denied      -> "The user denied camera access"
  | Camera_access_restricted  -> "Camera access is restricted (due to parental
  controls, organization security configuration profiles, or similar reasons)."
  | Back_camera_unavailable   -> "The back camera is unavailable."
  | Front_camera_unavailable  -> "The front camera is unavailable."
  | Camera_unavailable        -> "The camera is unavailable because it doesn't
  exist or is otherwise unable to be configured."
  | Scan_canceled             -> "Scan was canceled by the cancelScan() method."
  | Light_unavailable         -> "The device light is unavailable because it
  doesn't exist or is otherwise unable to be configured."
  | Open_settings_unavailable -> "The device is unable to open settings."

(* Error javascript object, used by some callbacks in qr_scanner object *)
type error =
  <
    _message                        : Js.js_string Js.t Js.readonly_prop ;
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
type camera =
  | Front
  | Back

let camera_to_int c = match c with
  | Front   -> 1
  | Back    -> 0
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
let qr_scanner () = Js.Unsafe.js_expr ("QRScanner")
(* -------------------------------------------------------------------------- *)
