(* -------------------------------------------------------------------------- *)
[@@@js.stop]
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
[@@@js.start]

[@@@js.implem
type error_name =
  | Camera_access_denied
  | Unexpected_error
  | Camera_access_restricted
  | Back_camera_unavailable
  | Front_camera_unavailable
  | Camera_unavailable
  | Scan_canceled | Light_unavailable
  | Open_settings_unavailable

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
]

(* Error javascript object, used by some callbacks in qrscanner object *)
class error : Ojs.t ->
  object
    inherit Ojs.obj
    method message                         : string
    method code                            : int
    method name                            : string
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Status javascript object, used by some callbacks in qrscanner object *)
class status : Ojs.t ->
  object
    inherit Ojs.obj
    method authorized                         : bool
    method denied                             : bool
    method restricted                         : bool
    method prepared                           : bool
    method scanning                           : bool
    method previewing                         : bool
    method webview_background_is_transparent  : bool
    method light_enabled                      : bool
    method can_open_settings                  : bool
    method can_enable_light                   : bool
    method current_camera                     : int
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Define the front and back camear with a sum type. Can be used for use_camera
 * method on qrscanner object to type. Don't forget to use camera_to_int to
 * apply it to use_camera
 *)
[@@@js.stop]
type camera
val camera_to_int : camera -> int
[@@@js.start]

[@@@js.implem
type camera =
  | Front
  | Back

let camera_to_int c = match c with
  | Front   -> 1
  | Back    -> 0
]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* qrscanner javascript object
 * error in callbacks are of type error option because if everything went
 * right, error is set to null.
 *)
class qrscanner : Ojs.t ->
  object
    inherit Ojs.obj
    method prepare          :   (error option -> status -> unit) -> unit
    method scan             :   (error option -> string -> unit) -> unit
    method cancel_scan      :   (status -> unit) -> unit
    method show             :   (status -> unit) -> unit
    method hide             :   (status -> unit) -> unit
    method enable_light     :   (error option -> status -> unit) -> unit
    method disable_light    :   (error option -> status -> unit) -> unit
    method use_camera       :   int -> (error option -> status -> unit) -> unit
    method use_front_camera :   (error option -> status -> unit) -> unit
    method use_back_camera  :   (error option -> status -> unit) -> unit
    method pause_preview    :   (status -> unit) -> unit
    method resume_preview   :   (status -> unit) -> unit
    method open_settings    :   (error option -> status -> unit) -> unit
    method get_status       :   (status -> unit) -> unit
    method destroy          :   (status -> unit) -> unit
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val t : unit -> qrscanner
[@@js.get "QRScanner"]
(* -------------------------------------------------------------------------- *)
