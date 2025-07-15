(*Copy this simple example into a new dune project. Make sure to import yojson and rpc_lib in the dune file!*)

open Rpc_lib.Basic
open Yojson

let hello (json : Yojson.Basic.t) : Yojson.Basic.t = 
  Printf.printf "hello world\n"; json;;

all_request_calls := StringMap.empty |> add_to_calls "hello" hello;;

let interp buf =
  let packet = Packet.t_of_str buf in
  match packet.body with 
  | Request req -> (call_request req.method_ req.params) |> Yojson.Basic.pretty_print Format.std_formatter;
  | _ -> raise (Json_error "issue")

let rec server () = 
  let input = read_line () in
  interp input; server ();;

let () = server ()
