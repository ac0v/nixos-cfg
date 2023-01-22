final: prev: {
  python310 = prev.python310.override {
    packageOverrides = final: prev: {
      ephemeral-port-reserve = prev.ephemeral-port-reserve.overrideAttrs (oldAttrs: rec {
        doCheck = false;
        doInstallCheck = false;
        disabledTests = [
          "test_fqdn"
        ];
      });
      eventlet = prev.eventlet.overrideAttrs (oldAttrs: rec {
        doCheck = false;
        doInstallCheck = false;
      });
    };
  };
}

#self: super: {
#  pythonOverrides = python-self: python-super: {
#    python310-ephemeral-port-reserve = python-super.python310-ephemeral-port-reserve.buildPythonPackage.overrideAttrs (x: {
#      doCheck = false;
#      doInstallCheck = false;
#
#      disabledTests = [
#        "test_fqdn"
#      ];
#    });
#  };
#  python310Packages = super.python310Packages.overrideAttrs (old: {
#    ephemeral-port-reserve
#    doCheck = false;
#    doInstallCheck = false;
#  });
#}

#      (self: super: {
#        pythonOverrides = python-self: python-super: {
#          astroid = python-super.astroid.overridePythonAttrs (x: {
#            disabled = builtins.trace (false) false;
#          });
#          python39 =
#            super.python39.override
#              {
#                packageOverrides = self.pythonOverrides;
#              };
#        };
#      })
