import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

import "components"

Maui.ApplicationWindow
{
    id: root
    title: "Kuill"
    readonly property font defaultFont : Qt.font({family: "Noto Sans Mono", pointSize: Maui.Style.fontSizes.huge})

    headBar.visible: true
    headerPositioning: ListView.InlineHeader

    headBar.middleContent: Maui.ToolBar
    {
        id: _toolbar
        middleContent: [
            ToolButton
            {
                id: _button1
                text: "penna"
            },
            ToolButton
            {
                id: _button2
                text: "evidenziatore"
            },
            ToolButton
            {
                id: _button3
                text: "prova"
            }
        ]
    }

    Notebook
    {
        id: _notebook
    }

}
