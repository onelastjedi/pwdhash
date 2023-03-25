program pwdhash;

uses
  RegExpr, Process;

var
  re: TRegExpr;
  uri: string;
  plain: string;
  digest: ansistring;
  prefix: string;
  size: integer;
  nonalpha: boolean;
  
begin
  re:= TRegExpr.Create;
  re.Expression:= '\W';
  prefix:= '@@';

  write('Domain: ');
  readln(uri);
  write('Password: ');
  readln(plain);

  size:= length(plain) + length(prefix);
  nonalpha:= re.Exec(plain);

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

  if digest = '' then
  begin
    writeln('OpenSSL is not installed. Exited.');
    exit;
  end;

  writeln(digest);
  
  writeln(size);
end.
