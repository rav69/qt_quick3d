//

// variant 'original'
import QtQuick 2.15
import QtQuick3D 1.15

View3D {
    id: root

    property string modelName: ""
    property real modelScale: 1.0
    property vector3d cameraPosition: Qt.vector3d(0, 25, 150)
    property int rotationDuration: 8000

    environment: SceneEnvironment {
        backgroundMode: SceneEnvironment.Transparent
    }

    PerspectiveCamera {
        position: root.cameraPosition
    }

    DirectionalLight {
    }

    DynamicModel {
        id: model
        modelName: root.modelName
        scale: Qt.vector3d(root.modelScale, root.modelScale, root.modelScale)

        NumberAnimation on eulerRotation.y {
            from: 0
            to: 360
            duration: root.rotationDuration
            loops: Animation.Infinite
        }
    }



    // test cube
    Model {
        visible: false
        source: "#Cube"
        position: Qt.vector3d(0, 0, 0)
        scale: Qt.vector3d(.25, .25, .25)
        materials: DefaultMaterial {
            diffuseColor: "red"
            specularAmount: 0.5
        }
        NumberAnimation on eulerRotation.y {
            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
        }
        NumberAnimation on eulerRotation.x {
            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
        }
        NumberAnimation on eulerRotation.z {
            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
        }
    }
}

// variant 'direction light'
//import QtQuick 2.15
//import QtQuick3D 1.15

//View3D {
//    id: root

//    property string modelName: ""
//    property real modelScale: 1.0
//    property vector3d cameraPosition: Qt.vector3d(0, 25, 150)
//    property int rotationDuration: 8000

//    environment: SceneEnvironment {
//        backgroundMode: SceneEnvironment.Transparent
//    }

//    PerspectiveCamera {
//        id: camera
//        position: root.cameraPosition
//    }

//    // ========== СВЕТ ИЗ ПОЗИЦИИ КАМЕРЫ (Qt 5.15.2) ==========

//    // Вариант 1: Направленный свет
//    DirectionalLight {
//        id: directionalLight
//        color: "white"
//        ambientColor: "#404060"
//        brightness: .5   // ← В Qt 5.15.2 используется brightness
//        // В Qt 5.15.2 направление задаётся через rotation
//        rotation: Qt.quaternion.fromAxisAndAngle(Qt.vector3d(1, 0, 0), 0)
//    }

//    // Вариант 2: Точечный свет в позиции камеры
//    PointLight {
//        id: pointLight
//        color: "#fff5e6"
//        brightness: 0.8   // ← brightness вместо intensity
//        position: camera.position

//        // Настройки затухания (в Qt 5.15.2 свои названия)
//        constantFade: 0.0
//        linearFade: 0.0
//        quadraticFade: 0.005
//    }

//    // Контейнер для модели
//    Node {
//        id: modelContainer

//        DynamicModel {
//            id: model
//            modelName: root.modelName
//            scale: Qt.vector3d(root.modelScale, root.modelScale, root.modelScale)

//            NumberAnimation on eulerRotation.y {
//                from: 0
//                to: 360
//                duration: root.rotationDuration
//                loops: Animation.Infinite
//            }
//        }
//    }

//    // test cube
//    Model {
//        visible: false
//        source: "#Cube"
//        position: Qt.vector3d(0, 0, 0)
//        scale: Qt.vector3d(.25, .25, .25)
//        materials: DefaultMaterial {
//            diffuseColor: "red"
//            specularAmount: 0.5
//        }
//        NumberAnimation on eulerRotation.y {
//            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//        }
//        NumberAnimation on eulerRotation.x {
//            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//        }
//        NumberAnimation on eulerRotation.z {
//            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//        }
//    }
//}


// variant 'rotate model mouse, informer'
//import QtQuick 2.15
//import QtQuick3D 1.15

//View3D {
//    id: root

//    property string modelName: ""
//    property real modelScale: 1.0
//    property vector3d cameraPosition: Qt.vector3d(0, 25, 150)
//    property int rotationDuration: 8000

//    // Свойства для управления наклоном
//    property real tiltX: 0
//    property real tiltY: 0
//    property real tiltZ: 0

//    // Для отслеживания перетаскивания
//    property point lastMousePos: Qt.point(0, 0)
//    property bool isDragging: false

//    environment: SceneEnvironment {
//        backgroundMode: SceneEnvironment.Transparent
//    }

//    PerspectiveCamera {
//        position: root.cameraPosition
//    }

//    DirectionalLight {
//    }

//    // Контейнер для модели с трансформациями
//    Node {
//        id: modelContainer

//        // Применяем наклоны к контейнеру
//        eulerRotation: Qt.vector3d(root.tiltX, root.tiltY, root.tiltZ)

//        DynamicModel {
//            id: model
//            modelName: root.modelName
//            scale: Qt.vector3d(root.modelScale, root.modelScale, root.modelScale)

//            NumberAnimation on eulerRotation.y {
//                from: 0
//                to: 360
//                duration: root.rotationDuration
//                loops: Animation.Infinite
//            }
//        }
//    }

//    // Обработчик событий мыши
//    MouseArea {
//        anchors.fill: parent

//        onPressed: {
//            root.isDragging = true
//            root.lastMousePos = Qt.point(mouse.x, mouse.y)
//            cursorShape = Qt.ClosedHandCursor
//        }

//        onPositionChanged: {
//            if (root.isDragging) {
//                // Вычисляем смещение мыши
//                var dx = mouse.x - root.lastMousePos.x
//                var dy = mouse.y - root.lastMousePos.y

//                // Обновляем углы наклона (чувствительность можно регулировать)
//                root.tiltX += dy * 0.2  // Движение вверх/вниз - наклон по X
//                root.tiltY += dx * 0.2  // Движение влево/вправо - наклон по Y

//                // Обновляем позицию для следующего шага
//                root.lastMousePos = Qt.point(mouse.x, mouse.y)
//            }
//        }

//        onReleased: {
//            root.isDragging = false
//            cursorShape = Qt.ArrowCursor
//        }

//        // Для сброса наклона по двойному клику
//        onDoubleClicked: {
//            root.tiltX = 0
//            root.tiltY = 0
//            root.tiltZ = 0
//        }
//    }

//    // Информационная панель с отображением углов
//    Rectangle {
//        anchors {
//            bottom: parent.bottom
//            left: parent.left
//            margins: 20
//        }
//        width: 250
//        height: 100
//        color: "#cc000000"
//        radius: 8

//        Column {
//            anchors {
//                centerIn: parent
//                margins: 10
//            }
//            spacing: 4

//            Text {
//                text: "🖱️ Перетаскивайте для наклона модели"
//                color: "white"
//                font.pixelSize: 11
//                font.family: "monospace"
//            }
//            Text {
//                text: "🔄 Двойной клик - сброс наклона"
//                color: "#aaaaaa"
//                font.pixelSize: 10
//                font.family: "monospace"
//            }
//            Text {
//                text: "Наклон X: " + root.tiltX.toFixed(1) + "°  Y: " + root.tiltY.toFixed(1) + "°"
//                color: "#88ccff"
//                font.pixelSize: 11
//                font.family: "monospace"
//            }
//        }
//    }

//    // test cube
//    Model {
//        visible: false
//        source: "#Cube"
//        position: Qt.vector3d(0, 0, 0)
//        scale: Qt.vector3d(.25, .25, .25)
//        materials: DefaultMaterial {
//            diffuseColor: "red"
//            specularAmount: 0.5
//        }
//        NumberAnimation on eulerRotation.y {
//            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//        }
//        NumberAnimation on eulerRotation.x {
//            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//        }
//        NumberAnimation on eulerRotation.z {
//            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//        }
//    }
//}


///*
//        DirectionalLight {
//            id: keyLight
//            eulerRotation.x: -45
//            eulerRotation.y: 45
//            brightness: 100  // Увеличили с 100 до 200
//        }

//        // Заполняющий свет (убирает жёсткие тени)
//        DirectionalLight {
//            id: fillLight
//            eulerRotation.x: 30
//            eulerRotation.y: -135
//            brightness: 100
//            color: "#aaccff"  // Холодный оттенок для объёма
//        }
//*/
