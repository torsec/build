RUST_KEYLIME_EXT_VERSION = 0.2.7
RUST_KEYLIME_EXT_SOURCE = local
RUST_KEYLIME_EXT_SITE = $(BR2_PACKAGE_RUST_KEYLIME_EXT_SITE)
RUST_KEYLIME_EXT_SITE_METHOD = local
RUST_KEYLIME_EXT_DEPENDENCIES = host-rustc host-pkgconf \
				tpm2-tss libopenssl

RUST_KEYLIME_EXT_CARGO_ENV = \
     CARGO_HOME=/home/enrico/.cargo

# Install steps
define RUST_KEYLIME_EXT_INSTALL_TARGET_CMDS
    $(INSTALL) -D \
        $(@D)/target/$(RUSTC_TARGET_NAME)/release/keylime_agent \
        $(TARGET_DIR)/usr/bin/

    mkdir -p $(TARGET_DIR)/var/lib/keylime

    $(INSTALL) -D $(@D)/keylime-agent.conf $(TARGET_DIR)/etc/keylime/agent.conf
endef


$(eval $(cargo-package))
