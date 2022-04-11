#
# Copyright (C) 2016-2017 GitHub 
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
# SUBMENU:=3. Applications

include $(TOPDIR)/rules.mk

PKG_NAME:=default-settings
PKG_VERSION:=2
PKG_RELEASE:=19
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/default-settings
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=LuCI support for Default Settings
  MAINTAINER:=Eliminater74
  PKGARCH:=all
  DEPENDS:=+luci-base +luci +bash
endef

define Package/default-settings/description
	Language Support Packages.
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/
endef

define Build/Prepare
  chmod -R +x ./files/bin ./files/sbin ./files/etc/profile.d ./files/etc/rc.d ./files/usr/share target/*/{*,}/files/{etc/init.d,usr/bin} >/dev/null || true
endef

define Build/Compile
endef

define Package/default-settings/install
    echo $(BOARD)$(TARGETID)
    $(INSTALL_DIR) $(1)/etc/uci-defaults
    $(INSTALL_CONF) ./files/zzz-default-settings $(1)/etc/uci-defaults/99-default-settings

    $(INSTALL_DIR) $(1)/bin
    $(INSTALL_BIN) ./files/bin/* $(1)/bin

    $(INSTALL_DIR) $(1)/sbin
    $(INSTALL_BIN) ./files/sbin/* $(1)/sbin

    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) ./files/usr/bin/* $(1)/usr/bin

    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/admin_status/index/links.htm
    $(INSTALL_BIN) ./files/usr/lib/lua/luci/view/admin_status/index/links.htm $(1)/usr/lib/lua/luci/view/admin_status/index/links.htm

    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config

    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d

    $(INSTALL_DIR) $(1)/etc/profile.d
    $(INSTALL_BIN) ./files/etc/profile.d/* $(1)/etc/profile.d

    $(INSTALL_DIR) $(1)/etc/rc.d
    $(INSTALL_BIN) ./files/etc/rc.d/* $(1)/etc/rc.d
endef

$(eval $(call BuildPackage,default-settings))
