include_directories(
    # ${CMAKE_CURRENT_SOURCE_DIR}/utils
    # ${CMAKE_CURRENT_BINARY_DIR}/utils
    #
    # ${CMAKE_CURRENT_SOURCE_DIR}/syncing
    # ${CMAKE_CURRENT_BINARY_DIR}/syncing
    #
    # ${CMAKE_CURRENT_SOURCE_DIR}/providers
    # ${CMAKE_CURRENT_BINARY_DIR}/providers
    #
    # ${CMAKE_CURRENT_SOURCE_DIR}/controllers
    # ${CMAKE_CURRENT_BINARY_DIR}/controllers
    #
    # ${CMAKE_CURRENT_SOURCE_DIR}/models
    # ${CMAKE_CURRENT_BINARY_DIR}/models
    )

if(QUICK_COMPILER)
    qtquick_compiler_add_resources(quill_QML_QRC qml.qrc)
else()
    qt5_add_resources(quill_QML_QRC qml.qrc)
endif()

set(quill_SRCS
    main.cpp
    )

set(quill_HDRS
    )

set(quill_ASSETS
    )

if(ANDROID)
    add_library(${PROJECT_NAME} SHARED
        ${quill_SRCS}
        ${quill_HDRS}
        ${quill_ASSETS}
        ${quill_QML_QRC})
else()
    add_executable(${PROJECT_NAME}
        ${quill_SRCS}
        ${quill_HDRS}
        ${quill_ASSETS}
        ${quill_QML_QRC})
endif()


if (ANDROID)
    target_link_libraries(${PROJECT_NAME}
        Qt5::AndroidExtras
        Qt5::QuickControls2)
    kde_source_files_enable_exceptions(${PROJECT_NAME} index.cpp)

    #    set_target_properties(create-apk-${PROJECT_NAME} PROPERTIES ANDROID_APK_DIR "${APK_DIR}")

elseif(UNIX)
    target_link_libraries(${PROJECT_NAME} KF5::KIOCore KF5::KIOFileWidgets  Qt5::DBus)
endif()

if(UNIX OR WIN32 OR APPLE AND NOT ANDROID)
    target_link_libraries(${PROJECT_NAME} Qt5::Widgets)
endif()

target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME}
    MauiKit
    MauiKit::FileBrowsing
    Qt5::Quick
    Qt5::Qml
    KF5::CoreAddons
    KF5::I18n)

#TODO: port to ecm_install_icons()
if(UNIX AND NOT APPLE AND NOT ANDROID)
    install(TARGETS ${PROJECT_NAME} ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
    # install(FILES org.kde.index.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})

    # install(FILES assets/index.svg DESTINATION ${KDE_INSTALL_ICONDIR}/hicolor/scalable/apps)
endif()
