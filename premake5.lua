project "GLFW"
    kind "StaticLib"
    language "C"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h",
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c",
        "src/egl_context.c",
        "src/osmesa_context.c",
        "src/platform.c",
        "src/internal.h"
    }

    filter "system:windows"
        buildoptions { "-std=c11", "-lgdi32" }
        systemversion "latest"
        staticruntime "On"

        files {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c",
            "src/win32_module.c"
        }

        defines {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
        }

    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"

    filter "system:linux"
        pic "On"
        systemversion "latest"
        staticruntime "On"
        buildoptions { "-std=c11" }

        files {
            -- X11 platform
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/x11_platform.h",

            -- Wayland platform
            "src/wl_init.c",
            "src/wl_monitor.c",
            "src/wl_window.c",
            "src/wl_platform.h",

            -- XKB
            "src/xkb_unicode.c",
            "src/xkb_unicode.h",

            -- Linux joystick support
            "src/linux_joystick.c",
            "src/linux_joystick.h",

            -- POSIX layer
            "src/posix_module.c",
            "src/posix_poll.c",
            "src/posix_poll.h",
            "src/posix_thread.c",
            "src/posix_thread.h",
            "src/posix_time.c",
            "src/posix_time.h",

            -- Null platform
            "src/null_init.c",
            "src/null_monitor.c",
            "src/null_window.c",
            "src/null_joystick.c",
            "src/null_joystick.h",
            "src/null_platform.h",

            -- GLX context
            "src/glx_context.c"
        }

        defines {
            "_GLFW_X11",
            "_GLFW_HAS_XKB"
        }

        links {
            "dl",
            "m",
            "pthread",
            "X11",
            "Xrandr",
            "Xi",
            "Xcursor",
            "Xxf86vm",
            "Xinerama",
            "wayland-client",
            "wayland-cursor",
            "wayland-egl",
            "xkbcommon"
        }
