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
                text: "Pen"
                onClicked:
                {
                    _notebook.brushShape = 0
                    _notebook.brushOpacity = 1
                    _notebook.paintColor = _colorPicker.currentColor
                }
            },
            ToolButton
            {
                id: _button2
                text: "Highlighter"
                onClicked:
                {
                    _notebook.brushShape = 1
                    _notebook.brushOpacity = 0.1
                    _notebook.paintColor = _colorPicker.currentColor
                }
            },
            ToolButton
            {
                id: _button3
                text: "Eraser"
                onClicked:
                {
                    _notebook.brushShape = 0
                    _notebook.brushOpacity = 1
                    _notebook.paintColor = _notebook.bgColor
                }
            },
            Maui.ColorsRow
            {
                id: _colorPicker
                colors: ["blue", "red", "green"]
                currentColor: "blue"
                onColorPicked: _notebook.bgColor ? _notebook.paintColor = currentColor : _notebook.paintColor = color
            }
        ]
    }

    Notebook
    {
        id: _notebook
    }

}
