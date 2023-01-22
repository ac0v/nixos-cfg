self: super: {
  rustup = super.rustup.overrideAttrs (o: {
    doCheck = false;
    doInstallCheck = false;
  });
}
