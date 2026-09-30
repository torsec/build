RUST_KEYLIME_EXT_VERSION = 0.2.7
RUST_KEYLIME_EXT_SOURCE = local
RUST_KEYLIME_EXT_SITE = /home/laga/optee_keylime/rust-keylime
RUST_KEYLIME_EXT_SITE_METHOD = local
RUST_KEYLIME_EXT_DEPENDENCIES = host-rustc host-pkgconf \
				tpm2-tss libopenssl

RUST_KEYLIME_EXT_CARGO_ENV = \
     CARGO_HOME=/home/laga/.cargo \
     BINDGEN_EXTRA_CLANG_ARGS="--target=$(GNU_TARGET_NAME) --sysroot=$(STAGING_DIR) -I$(STAGING_DIR)/usr/include"

# Install steps
define RUST_KEYLIME_EXT_INSTALL_TARGET_CMDS
    $(INSTALL) -D \
        $(@D)/target/$(RUSTC_TARGET_NAME)/release/keylime_agent \
        $(TARGET_DIR)/usr/bin/

    mkdir -p $(TARGET_DIR)/var/lib/keylime
    mkdir -p $(TARGET_DIR)/etc/keylime


    $(INSTALL) -D $(@D)/keylime-agent.conf $(TARGET_DIR)/etc/keylime/
endef

# NON PERMESSE SE NON SEI ROOT
# adduser keylime
# chown keylime:keylime /dev/tpm0
# chown keylime:keylime /dev/tpmrm0

# run with: KEYLIME_AGENT_CONFIG=/etc/keylime/keylime-agent.conf keylime_agent

$(eval $(cargo-package))
