project "GLFW"
    kind "StaticLib"
    language "C"
    staticruntime "on"

    targetdir ("bin/" .. outputDir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputDir .. "/%{prj.name}")

    files {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",

        -- Core source
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c",
        "src/platform.c",
        "src/internal.h",
        "src/osmesa_context.c",
        "src/egl_context.c",
        "src/null_init.c",
        "src/null_monitor.c",
        "src/null_window.c",
        "src/null_joystick.c",
        "src/null_joystick.h",
        "src/null_platform.h"
    }

    filter "system:windows"
        systemversion "latest"

        files {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c",
            "src/win32_module.c",
            "src/win32_platform.h",
            "src/win32_joystick.h",
            "src/win32_thread.h",
            "src/win32_time.h"
        }

        defines {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
        }

    filter "system:linux"
        pic "On"
        systemversion "latest"

        files {
            -- X11
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/x11_platform.h",

            -- Wayland
            "src/wl_init.c",
            "src/wl_monitor.c",
            "src/wl_window.c",
            "src/wl_platform.h",

            -- XKB
            "src/xkb_unicode.c",
            "src/xkb_unicode.h",

            -- Linux input
            "src/linux_joystick.c",
            "src/linux_joystick.h",

            -- POSIX platform
            "src/posix_module.c",
            "src/posix_poll.c",
            "src/posix_poll.h",
            "src/posix_thread.c",
            "src/posix_thread.h",
            "src/posix_time.c",
            "src/posix_time.h",

            -- GLX
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
