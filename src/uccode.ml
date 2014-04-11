open Printf

let utf8_pack11 code =
  let byte1 = (code lsr 6) + 0xC0 in
  let byte2 = (code land 0x3F) + 0x80 in
  (byte1, byte2)

let utf8_pack16 code =
  let byte1 = (code lsr 12) + 0xE0 in
  let byte2 = ((code land 0xFFF) lsr 6)+0x80 in
  let byte3 = (code land 0x3F) + 0x80 in
  (byte1, byte2, byte3)

let print_utf8_correspondance code =
  if code < 0x80 then
    printf "U+%04X ^^%02x \\%03o (%c)\n"
      code code code (Char.chr code)
  else if code < 0x800 then
    let byte1, byte2 = utf8_pack11 code in
    printf "U+%04X ^^%02x^^%02x \\%03o\\%03o\n"
      code byte1 byte2 byte1 byte2
  else if code < 0x10000 then
    let byte1, byte2, byte3 = utf8_pack16 code in
    printf "U+%04X ^^%02x^^%02x^^%02x \\%03o\\%03o\\%03o\n"
      code byte1 byte2 byte3 byte1 byte2 byte3
  else
    invalid_arg "print_utf8_correspondance"


let table_line ncode ucode lcode =
  let (nbyte1, nbyte2) = utf8_pack11 ncode in
  let (ubyte1, ubyte2) = utf8_pack11 ucode in
  let (lbyte1, lbyte2) = utf8_pack11 lcode in
  if (nbyte1 = ubyte1) && (nbyte1 = lbyte1) then
    printf "\\lccode\"%02X=\"%02X \\uccode\"%02X=\"%02X %% U+%04X\n"
      nbyte2 lbyte2 nbyte2 ubyte2 ncode
  else
    printf "%% Failure ^^%02x^^%02x (U+%04X) ^^%02x^^%02x (U+%04X)\n"
      ubyte1 ubyte2 ucode lbyte1 lbyte2 lcode

let upperchars =
  let answer = String.make 128 '\000' in
  for i = 0 to 127 do
    answer.[i] <- Char.chr (128 + i)
  done;
  answer

let processchar nc uc lc =
  let ncode = Char.code nc in
  let ucode = Char.code uc in
  let lcode = Char.code lc in
  table_line ncode ucode lcode

let lowercase_char c =
  let code = Char.code c in
  if code = 0xD7 || code = 0xDF || code = 0xF7 then
    c
  else if code < 0xC0 then
    if code mod 2 = 0 then
      Char.chr(code + 1)
    else
      c
  else if code < 0xE0 then
    Char.chr (code + 0x20)
  else
    c

let uppercase_char c =
  let code = Char.code c in
  if code = 0xD7 || code = 0xDF || code = 0xF7 then
    c
  else if code < 0xC0 then
    if code mod 2 = 0 then
      c
    else
      Char.chr(code - 1)
  else if code < 0xE0 then
    c
  else
    Char.chr (code - 0x20)

let uppercase =
  String.map uppercase_char

let lowercase =
  String.map lowercase_char

let process () =
  let u = uppercase upperchars in
  let l = lowercase upperchars in
  for i = 0 to 127 do
    processchar upperchars.[i] u.[i] l.[i]
  done


let show_correspondance () =
  begin
    List.iter print_utf8_correspondance [
      0x2014; (* Tiret cadratin *)
      0x00C9; (* E acute *)
      0x00E9; (* e acute *)
      0x0152; (* Œ acute *)
      0x0153; (* œ acute *)
    ];
    for code = 0x80 to 0xFF do
      print_utf8_correspondance code;
    done;
  end


let () = show_correspondance ()
