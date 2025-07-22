QT += quick

SOURCES += main.cpp

resources.files = \
    main.qml \
    FigureButton.qml \
    SideButton.qml \
    DisplayArea.qml
resources.prefix = /quickapp
RESOURCES += resources \
    resources.qrc

# Пути для импорта
QML_IMPORT_PATH += $$PWD/components $$PWD
QML_DESIGNER_IMPORT_PATH += $$PWD/components

# Правила установки
target.path = $$[QT_INSTALL_EXAMPLES]/$$TARGET
INSTALLS += target

DISTFILES += \
    DisplayArea.qml \
    StatusBar.qml
