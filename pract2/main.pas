program test;
type
   Buffer = array [1..50] of longint;

var chan: channel of Buffer;

process FillBuffer(var buffer: Buffer; value: longint);
var
   i: Integer;
begin
   for i := 1 to 50 do
      buffer[i] := value;
end;

process DisplayBuffer;
var
   buffer, received: Buffer;
begin
   FillBuffer(buffer, 5);

   while true do
   begin
      chan ? received;
      chan ! buffer;
      buffer := received;
      FillBuffer(buffer, 5);
      writeln('Display buffer');
   end;
end;

process DbMonitor;
var
   buffer, received: Buffer;
begin
   FillBuffer(buffer, 1);

   while true do
   begin
      chan ? received;
      chan ! buffer;
      buffer := received;
      FillBuffer(buffer, 1);
      writeln('DB Monitor');
   end;
end;

begin
   cobegin
     DisplayBuffer;
     DbMonitor;
   coend;
end.

