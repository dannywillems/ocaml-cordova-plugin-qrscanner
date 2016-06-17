(* -------------------------------------------------------------------------- *)
type error_type =
  | Unexpected_error [@js 0]
  | Camera_access_denied [@js 1]
  | Camera_access_restricted [@js 2]
  | Back_camera_unavailable [@js 3]
  | Front_camera_unavailable [@js 4]
  | Camera_unavailable [@js 5]
  | Scan_canceled [@js 6]
  | Light_unavailable [@js 7]
  | Open_settings_unavailable [@js 8]
  [@@js.enum]

(* Error javascript object, used by some callbacks in qrscanner object *)
type error = private Ojs.t
val message                             : error -> string
val code                                : error -> error_type
val name                                : error -> string
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Define the front and back camear with a sum type. Can be used for use_camera
 * method on qrscanner object to type. Don't forget to use camera_to_int to
 * apply it to use_camera
 *)
type camera =
  | Front [@js 1]
  | Back [@js 0]
  [@@js.enum]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Status javascript object, used by some callbacks in qrscanner object *)
type status = private Ojs.t
val authorized                          : status -> bool
val denied                              : status -> bool
val restricted                          : status -> bool
val prepared                            : status -> bool
val scanning                            : status -> bool
val previewing                          : status -> bool
val webview_background_is_transparent   : status -> bool
val light_enabled                       : status -> bool
val can_open_settings                   : status -> bool
val can_enable_light                    : status -> bool
val current_camera                      : status -> camera
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* qrscanner javascript object
 * error in callbacks are of type error option because if everything went
 * right, error is set to null.
 *)
val prepare          :   (error option -> status -> unit) -> unit
[@@js.global "QRScanner.prepare"]

val scan             :   (error option -> string -> unit) -> unit
[@@js.global "QRScanner.scan"]

val cancel_scan      :   (status -> unit) -> unit
[@@js.global "QRScanner.cancelScan"]

val show             :   (status -> unit) -> unit
[@@js.global "QRScanner.show"]

val hide             :   (status -> unit) -> unit
[@@js.global "QRScanner.hide"]

val enable_light     :   (error option -> status -> unit) -> unit
[@@js.global "QRScanner.enableLight"]

val disable_light    :   (error option -> status -> unit) -> unit
[@@js.global "QRScanner.disableLight"]

val use_camera       :   camera -> (error option -> status -> unit) -> unit
[@@js.global "QRScanner.useCamera"]

val use_front_camera :   (error option -> status -> unit) -> unit
[@@js.global "QRScanner.useFromCamera"]

val use_back_camera  :   (error option -> status -> unit) -> unit
[@@js.global "QRScanner.useBackCamera"]

val pause_preview    :   (status -> unit) -> unit
[@@js.global "QRScanner.pausePreview"]

val resume_preview   :   (status -> unit) -> unit
[@@js.global "QRScanner.resumePreview"]

val open_settings    :   (error option -> status -> unit) -> unit
[@@js.global "QRScanner.openSettings"]

val get_status       :   (status -> unit) -> unit
[@@js.global "QRScanner.getStatus"]

val destroy          :   (status -> unit) -> unit
[@@js.global "QRScanner.destroy"]
(* -------------------------------------------------------------------------- *)
