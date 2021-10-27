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
    headBar.forceCenterMiddleContent: root.isWide

    // just a temporary toolbar to test various features of the canvas
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
            ToolButton
            {
                id: _button4
                text: "Line"
                onClicked:
                {
                    _notebook.brushShape = 1
                    _notebook.brushOpacity = 1
                    _notebook.paintColor = _colorPicker.currentColor
                }
            },
            ToolButton
            {
                id: _zoomIn
                text: "Zoom in"
                onClicked:
                {
                    _notebook.scale *= 0.25

                }
            },
            ToolButton
            {
                id: _zoomOut
                text: "Zoom out"
                onClicked:
                {
                    _notebook.scale /= 0.25
                }
            },
            Maui.ColorsRow
            {
                id: _colorPicker
                colors: ["blue", "red", "green"]
                currentColor: "blue"
                onColorPicked:
                {
                    if (_notebook.bgColor != color)
                    {
                        _notebook.paintColor = color
                        currentColor = color
                    }
                }
            },
            ToolButton
            {
                id: _button5
                text: "Save"
                onClicked:
                {
                    _notebook.saveToFile("prova.png")
                }
            },
            ToolButton
            {
                id: _addPage
                text: "Add page"
                onClicked:
                {
                    _notebook.addPage()
                }
            },
            ToolButton
            {
                id: _deletePage
                text: "Remove page"
                onClicked:
                {
                    _notebook.removePage()
                }
            }
        ]
    }

    Notebook
    {
        id: _notebook
        anchors.fill: parent

        // A4 starndard 700dpi (i think)
        pageWidth: 2480
        pageHeight: 3508
        scale: 0.1
    }



}
