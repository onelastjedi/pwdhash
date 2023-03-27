{ Program pwdhash generate hash based on
  domain and plain password }
program pwdhash;

{ Use regular expressions
  and os process }
uses
  RegExpr, Process;

{ Operate with variables }
var
  re: TRegExpr;
  uri: string;
  plain: string;
  digest: ansistring;
  prefix: string;
  size: integer;
  nonalpha: boolean;

begin
  { Get user input }
  write('Domain: ');
  readln(uri);
  write('Password: ');
  readln(plain);

  { Run openssl to get digest }
  RunCommand(
    '/bin/bash', 
    [
      '-c',
      'echo -n ' 
      + uri 
      + '| openssl md5 -hmac ' + plain 
      + ' -binary | openssl enc -base64 -A'
    ],
    digest
  );

  { Exit if no openssl installed }
  if digest = '' then
  begin
    writeln('OpenSSL is not installed. Exited.');
    exit;
  end;

  { Set desired vars }
  prefix:= '@@';
  re:= TRegExpr.Create;
  re.Expression:= '\W';
  size:= length(plain) + length(prefix);
  nonalpha:= re.Exec(plain);
  
  writeln(digest);
  writeln(size);
end.
