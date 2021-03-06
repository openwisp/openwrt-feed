#
# Copyright (C) 2014 OpenWisp.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openwisp-fw
PKG_VERSION:=1

include $(INCLUDE_DIR)/package.mk

define Package/openwisp-fw
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=OpenWisp Firmware config files
	MAINTAINER:=info@openwisp.org
	#this is a meta package suitable for any archs...
	PKG_ARCH:=all
	DEPENDS:=+uhttpd +hostapd +openvpn-openssl +dnsmasq +ntpdate +netcat +tc +ebtables +tcpdump +ip +kmod-sched
endef

define Package/openwisp-fw-mesh
	$(call Package/openwisp-fw)
	TITLE:=OpenWisp Firmware MESH extension
	DEPENDS:=openwisp-fw +olsrd # FIXME
endef

define Package/openwisp-fw-umts
	$(call Package/openwisp-fw)
	TITLE:=OpenWisp Firmware UMTS extension
	DEPENDS:=openwisp-fw +usb-modeswitch +comgt # FIXME
endef


define Package/openwisp-fw/description
	 meta package for OpenWisp firmware

	 This package can use extra file from targz fetched through wget using the $OPENWISP_CONF variable
endef

define Package/openwisp-fw-mesh/description
	 meta package for OpenWisp firmware - MESH
endef

define Package/openwisp-fw-umts/description
	 meta package for OpenWisp firmware - UMTS
endef

define Build/Compile
endef


define Package/openwisp-fw/install
	$(INSTALL_DIR) $(1)/
	$(CP) -r ./files/* $(1)/
	if [ -n $(OPENWISP_CONF) ]; then \
		wget $(OPENWISP_CONF) -O /tmp/custom-config.tgz; \
		tar xvzf /tmp/custom-config.tgz -C $(1)/; \
	fi
endef

define Package/openwisp-fw-mesh/install
	$(INSTALL_DIR) $(1)/
	#$(CP) -r ./files-mesh/* $(1)/
	#TODO fix owispconfig https://github.com/openwisp/OpenWISP-Firmware/blob/umts-improvement/deploy-firmware.sh#L469
endef

define Package/openwisp-fw-umts/install
	$(INSTALL_DIR) $(1)/
	$(CP) -r ./files-umts/* $(1)/
	#TODO config ttyXXX modem
	#TODO update inittab: https://github.com/openwisp/OpenWISP-Firmware/blob/umts-improvement/deploy-firmware.sh#L460
	#sed -i -e 's/failure 5/failure 4/g' -e 's/interval 1/interval 65535/g' $(1)/etc/ppp/options
endef


$(eval $(call BuildPackage,openwisp-fw))
$(eval $(call BuildPackage,openwisp-fw-mesh))
$(eval $(call BuildPackage,openwisp-fw-umts))
