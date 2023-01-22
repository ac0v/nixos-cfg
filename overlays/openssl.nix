self: super: {
  openssl = super.openssl.overrideAttrs (o: {
    patches = (o.patches or [ ] ) ++ [
      ../patches/openssl/use-etc-ssl-certs-dir.patch
    ];
  });
}
