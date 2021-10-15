import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

Maui.ApplicationWindow
{
    id: root
    title: currentTab ? currentTab.title : ""

    headBar.visible: false

    StackView
    {
        id:header

    }

}
