{
  config,
  lib,
  pkgs,
  ...
}:
{
  # ...
  config.services.postgresql = {
    enable = true;
    ensureDatabases = [ "calendar" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  origin-address  auth-method 
      local all       all     trust	  
      host  all       all     ::1/128         trust
      host  all       all     127.0.0.1/32    trust
    '';
  };
}
