libFiles=("libadreno_app_profiles.so" "libadreno_utils.so" "libCB.so" "libdmabufheap.so" "libgsl.so" "libllvm-glnext.so" "libllvm-qcom.so" "libllvm-qgl.so" "libOpenCL.so")

function dirPerm () {
    chmod 0755 "$1"
}

function filePerm () {
    chmod 0644 "$1"
}

function sameProcess () {
    chcon u:object_r:same_process_hal_file:s0 "$1"
}

function vendorFirmware () {
    chcon u:object_r:vendor_firmware_file:s0 "$1"
}

function systemLib () {
    chcon u:object_r:system_lib_file:s0 "$1"
}

for lib in /vendor/lib/
    do
        for file in "${libFiles[@]}"
            do
                sameProcess "$lib/$file"
                filePerm "$lib/$file"
        done
done

for libEgl in /vendor/lib/egl/*
    do
        systemLib $libEgl
        filePerm $libEgl
done

for libHw in /vendor/lib/hw
    do
        sameProcess $libHw/vulkan.adreno.so
        filePerm $libHw/vulkan.adreno.so
done

for lib64 in /vendor/lib64
    do
        for file in "${libFiles[@]}"
            do
                sameProcess "$lib64/$file"
                filePerm "$lib64/$file"
        done
done

for lib64Egl in /vendor/lib64/egl/*
    do
        systemLib $lib64Egl
        filePerm $lib64Egl
done

for lib64Hw in /vendor/lib64/hw
    do
        sameProcess $lib64Hw/vulkan.adreno.so
        filePerm $lib64Hw/vulkan.adreno.so
done