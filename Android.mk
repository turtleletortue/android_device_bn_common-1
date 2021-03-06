#
# Copyright (C) 2013 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifneq ($(filter ovation hummingbird,$(TARGET_DEVICE)),)
ifeq ($(TARGET_BOARD_PLATFORM),omap4)

LOCAL_PATH := $(call my-dir)

ifneq ($(TARGET_SIMULATOR),true)

#Create HDCP symlink
HDCP_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/hdcp.keys
HDCP_KEYS_FILE := /rom/devconf/hdcp.keys
$(HDCP_SYMLINK): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(HDCP_KEYS_FILE)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware
	@rm -rf $@
	$(hide) ln -fs $(HDCP_KEYS_FILE) $@

ALL_DEFAULT_INSTALLED_MODULES += $(HDCP_SYMLINK)

# for mm/mmm
all_modules: $(HDCP_SYMLINK)

#Create WLAN NVS symlink
WLAN_SYMLINK := $(TARGET_OUT_ETC)/firmware/ti-connectivity/wl1271-nvs.bin
WLAN_BIN_FILE := /rom/devconf/wl1271-nvs.bin
$(WLAN_SYMLINK): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(WLAN_BIN_FILE)"
	@mkdir -p $(TARGET_OUT_ETC)/firmware/ti-connectivity
	@rm -rf $@
	$(hide) ln -fs $(WLAN_BIN_FILE) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WLAN_SYMLINK)

# for mm/mmm
all_modules: $(WLAN_SYMLINK)

endif

LOCAL_PATH := $(call my-dir)

include $(call first-makefiles-under,$(LOCAL_PATH))

endif
endif
