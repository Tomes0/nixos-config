{ pkgs, ...}: let
  username = "tomi";
in {
  home = {
    packages = with pkgs; [
      hello
      cowsay
      lolcat
    ];

    file = {
      "hello.txt" = {
        text = ''
          #!/usr/bin/env bash
          
          echo 'Sup ${username}'
          echo 'Lonk script :)'
        
        '';
        executable = true;
      };
    };    

    inherit username;
    homeDirectory = "/home/${username}";


    stateVersion = "25.05";
  };


}
