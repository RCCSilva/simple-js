FROM debian:buster-slim

WORKDIR /build
RUN apt update && apt upgrade -y && apt install -y git curl python lsb-release sudo
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH="/build/depot_tools:${PATH}"
RUN gclient
RUN fetch v8
WORKDIR /build/v8
RUN git checkout branch-heads/10.1
RUN gclient sync
RUN ./build/install-build-deps.sh --no-syms --no-chromeos-fonts --no-arm --no-nacl --no-backwards-compatible
RUN ./tools/dev/v8gen.py \
	x64.release \
	-- \
	target_os=\"linux\" \
	target_cpu=\"x64\" \
	v8_target_cpu=\"x64\" \
	v8_use_external_startup_data=false \
	v8_enable_future=true \
	is_official_build=false \
	is_component_build=false \
	is_cfi=false \
	is_asan=false \
	is_clang=false \
	use_custom_libcxx=false \
	use_custom_libcxx_for_host=false \
	use_sysroot=false \
	use_gold=false \
	is_debug=false \
	treat_warnings_as_errors=false \
	v8_enable_i18n_support=false \
	symbol_level=0 \
	v8_static_library=true \
	v8_monolithic=true \
	proprietary_codecs=false \
	toolkit_views=false \
	use_aura=false \
	use_dbus=false \
	use_gio=false \
	use_glib=false \
	use_ozone=false \
	use_udev=false \
	clang_use_chrome_plugins=false \
	v8_deprecation_warnings=false \
	v8_enable_gdbjit=false \
	v8_imminent_deprecation_warnings=false \
	v8_untrusted_code_mitigations=false \
	v8_use_snapshot=false \
	v8_enable_pointer_compression=true
RUN ninja -C out.gn/x64.release v8_monolith