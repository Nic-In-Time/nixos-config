{
  inputs,
  config,
  ...
}:
{

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "/home/nyx/.config/sops/age/keys.txt";
    defaultSopsFile = secrets/secrets.yaml;

    secrets."cloudflared-creds" = {
      owner = "nyx";
      group = "users";
      mode = "0400";
    };
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "535576c7-11ee-421f-8bb9-f7684c2458c0" = {
        credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
        ingress = {
          "ssh.nicintime.ca" = "ssh://localhost:22";
        };
        default = "http_status:404";
      };
    };
  };
}
