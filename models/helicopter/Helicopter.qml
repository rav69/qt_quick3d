import QtQuick 2.15
import QtQuick3D 1.15
//import QtQuick.Timeline 1.0

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: aW101_FBX
        eulerRotation.x: 90

        Node {
            id: object_2

            Node {
                id: rootNode

                Node {
                    id: aW101
                    x: 0.00579728
                    y: -14.2432
                    z: 14.8288
                    eulerRotation.x: 2.50448e-06
                    scale.x: 9.17739
                    scale.y: 9.17739
                    scale.z: 9.17739

                    Model {
                        id: aW101_AW101_AW101_sha_0
                        source: "meshes/aW101_AW101_AW101_sha_0.mesh"

                        PrincipledMaterial {
                            id: aW101_AW101_sha_material
                            baseColorMap: Texture {
                                source: "maps/0.png"
                                tilingModeHorizontal: Texture.Repeat
                                tilingModeVertical: Texture.Repeat
                            }
                            opacityChannel: Material.A
                            metalness: 0
                            roughness: 0.957705
                            cullMode: Material.NoCulling
                        }
                        materials: [
                            aW101_AW101_sha_material
                        ]
                    }

                    Model {
                        id: aW101_AW101_AW101_windows_sha_0
                        source: "meshes/aW101_AW101_AW101_windows_sha_0.mesh"
                        materials: [
                            aW101_AW101_sha_material
                        ]
                    }

                    Node {
                        id: aW101_backrotor
                        x: 0.533994
                        y: 2.13572
                        z: -8.86355
                        eulerRotation.x: -2.03556e-13

                        Model {
                            id: aW101_backrotor_AW101_AW101_sha_0
                            source: "meshes/aW101_backrotor_AW101_AW101_sha_0.mesh"
                            materials: [
                                aW101_AW101_sha_material
                            ]
                        }
                    }

                    Node {
                        id: aW101_propellar
                        x: 0.0344209
                        y: 2.53384
                        z: 3.21537
                        eulerRotation.x: -2.03556e-13

                        Model {
                            id: aW101_propellar_AW101_AW101_sha_0
                            source: "meshes/aW101_propellar_AW101_AW101_sha_0.mesh"
                            materials: [
                                aW101_AW101_sha_material
                            ]
                        }
                    }
                }
            }
        }
    }

//    Timeline {
//        id: timeline0
//        startFrame: 0
//        endFrame: 1000
//        currentFrame: 0
//        enabled: true
//        animations: [
//            TimelineAnimation {
//                duration: 1000
//                from: 0
//                to: 1000
//                running: true
//            }
//        ]

//        KeyframeGroup {
//            target: aW101_backrotor
//            property: "position"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(0.533994, 2.13572, -8.86355)
//            }
//        }

//        KeyframeGroup {
//            target: aW101_backrotor
//            property: "eulerRotation"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(0, 0, 0)
//            }
//            Keyframe {
//                frame: 16.6667
//                value: Qt.vector3d(18, 0, 0)
//            }
//            Keyframe {
//                frame: 33.3333
//                value: Qt.vector3d(36, 0, 0)
//            }
//            Keyframe {
//                frame: 66.6667
//                value: Qt.vector3d(72, 0, 0)
//            }
//            Keyframe {
//                frame: 83.3333
//                value: Qt.vector3d(89.9802, 0, 0)
//            }
//            Keyframe {
//                frame: 100
//                value: Qt.vector3d(72, 180, 180)
//            }
//            Keyframe {
//                frame: 133.333
//                value: Qt.vector3d(36, 180, 180)
//            }
//            Keyframe {
//                frame: 150
//                value: Qt.vector3d(18, 180, 180)
//            }
//            Keyframe {
//                frame: 166.667
//                value: Qt.vector3d(7.01671e-15, 180, 180)
//            }
//            Keyframe {
//                frame: 200
//                value: Qt.vector3d(-36, 180, 180)
//            }
//            Keyframe {
//                frame: 216.667
//                value: Qt.vector3d(-54, 180, 180)
//            }
//            Keyframe {
//                frame: 233.333
//                value: Qt.vector3d(-72, 180, 180)
//            }
//            Keyframe {
//                frame: 266.667
//                value: Qt.vector3d(-72, 0, 0)
//            }
//            Keyframe {
//                frame: 283.333
//                value: Qt.vector3d(-54, 0, 0)
//            }
//            Keyframe {
//                frame: 300
//                value: Qt.vector3d(-36, 0, 0)
//            }
//            Keyframe {
//                frame: 333.333
//                value: Qt.vector3d(9.15527e-05, 0, 0)
//            }
//            Keyframe {
//                frame: 350
//                value: Qt.vector3d(18.0001, 0, 0)
//            }
//            Keyframe {
//                frame: 366.667
//                value: Qt.vector3d(36.0001, 0, 0)
//            }
//            Keyframe {
//                frame: 400
//                value: Qt.vector3d(72.0002, 0, 0)
//            }
//            Keyframe {
//                frame: 416.667
//                value: Qt.vector3d(89.9802, 180, 180)
//            }
//            Keyframe {
//                frame: 433.333
//                value: Qt.vector3d(71.9999, 180, 180)
//            }
//            Keyframe {
//                frame: 466.667
//                value: Qt.vector3d(35.9999, 180, 180)
//            }
//            Keyframe {
//                frame: 483.333
//                value: Qt.vector3d(17.9999, 180, 180)
//            }
//            Keyframe {
//                frame: 500
//                value: Qt.vector3d(-0.00012207, 180, 180)
//            }
//            Keyframe {
//                frame: 533.333
//                value: Qt.vector3d(-36.0001, 180, 180)
//            }
//            Keyframe {
//                frame: 550
//                value: Qt.vector3d(-54.0001, 180, 180)
//            }
//            Keyframe {
//                frame: 566.667
//                value: Qt.vector3d(-72.0002, 180, 180)
//            }
//            Keyframe {
//                frame: 600
//                value: Qt.vector3d(-71.9999, 0, 0)
//            }
//            Keyframe {
//                frame: 616.667
//                value: Qt.vector3d(-53.9999, 0, 0)
//            }
//            Keyframe {
//                frame: 633.333
//                value: Qt.vector3d(-35.9999, 0, 0)
//            }
//            Keyframe {
//                frame: 666.667
//                value: Qt.vector3d(6.10352e-05, 0, 0)
//            }
//            Keyframe {
//                frame: 683.333
//                value: Qt.vector3d(18, 0, 0)
//            }
//            Keyframe {
//                frame: 700
//                value: Qt.vector3d(35.9999, 0, 0)
//            }
//            Keyframe {
//                frame: 733.333
//                value: Qt.vector3d(71.9999, 0, 0)
//            }
//            Keyframe {
//                frame: 750
//                value: Qt.vector3d(90, 0, 0)
//            }
//            Keyframe {
//                frame: 766.667
//                value: Qt.vector3d(72.0001, 180, 180)
//            }
//            Keyframe {
//                frame: 800
//                value: Qt.vector3d(36.0001, 180, 180)
//            }
//            Keyframe {
//                frame: 816.667
//                value: Qt.vector3d(18.0001, 180, 180)
//            }
//            Keyframe {
//                frame: 833.333
//                value: Qt.vector3d(0.000183105, 180, 180)
//            }
//            Keyframe {
//                frame: 866.667
//                value: Qt.vector3d(-35.9998, 180, 180)
//            }
//            Keyframe {
//                frame: 883.333
//                value: Qt.vector3d(-53.9999, 180, 180)
//            }
//            Keyframe {
//                frame: 900
//                value: Qt.vector3d(-71.9998, 180, 180)
//            }
//            Keyframe {
//                frame: 933.333
//                value: Qt.vector3d(-72.0002, 0, 0)
//            }
//            Keyframe {
//                frame: 950
//                value: Qt.vector3d(-54.0002, 0, 0)
//            }
//            Keyframe {
//                frame: 966.667
//                value: Qt.vector3d(-36.0004, 0, 0)
//            }
//            Keyframe {
//                frame: 983.333
//                value: Qt.vector3d(-18.0002, 0, 0)
//            }
//            Keyframe {
//                frame: 1000
//                value: Qt.vector3d(-4.21003e-14, 0, 0)
//            }
//        }

//        KeyframeGroup {
//            target: aW101_backrotor
//            property: "scale"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(1, 1, 1)
//            }
//        }

//        KeyframeGroup {
//            target: aW101_propellar
//            property: "position"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(0.0344209, 2.53384, 3.21537)
//            }
//        }

//        KeyframeGroup {
//            target: aW101_propellar
//            property: "eulerRotation"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(0, 0, 0)
//            }
//            Keyframe {
//                frame: 16.6667
//                value: Qt.vector3d(0, -18, 0)
//            }
//            Keyframe {
//                frame: 33.3333
//                value: Qt.vector3d(0, -36, 0)
//            }
//            Keyframe {
//                frame: 66.6667
//                value: Qt.vector3d(0, -72, 0)
//            }
//            Keyframe {
//                frame: 83.3333
//                value: Qt.vector3d(0, -90, 0)
//            }
//            Keyframe {
//                frame: 100
//                value: Qt.vector3d(-1.369e-14, -108, 2.16828e-15)
//            }
//            Keyframe {
//                frame: 133.333
//                value: Qt.vector3d(-1.1141e-14, -144, 5.67664e-15)
//            }
//            Keyframe {
//                frame: 150
//                value: Qt.vector3d(-9.18499e-15, -162, 6.67329e-15)
//            }
//            Keyframe {
//                frame: 166.667
//                value: Qt.vector3d(-7.01671e-15, -180, 7.01671e-15)
//            }
//            Keyframe {
//                frame: 200
//                value: Qt.vector3d(-2.89239e-15, 144, 5.67664e-15)
//            }
//            Keyframe {
//                frame: 216.667
//                value: Qt.vector3d(-1.34007e-15, 126, 4.12432e-15)
//            }
//            Keyframe {
//                frame: 233.333
//                value: Qt.vector3d(-3.43423e-16, 108, 2.16829e-15)
//            }
//            Keyframe {
//                frame: 266.667
//                value: Qt.vector3d(0, 72, 0)
//            }
//            Keyframe {
//                frame: 283.333
//                value: Qt.vector3d(0, 54, 0)
//            }
//            Keyframe {
//                frame: 300
//                value: Qt.vector3d(0, 36, 0)
//            }
//            Keyframe {
//                frame: 333.333
//                value: Qt.vector3d(0, -9.15527e-05, 0)
//            }
//            Keyframe {
//                frame: 350
//                value: Qt.vector3d(0, -18.0001, 0)
//            }
//            Keyframe {
//                frame: 366.667
//                value: Qt.vector3d(0, -36.0001, 0)
//            }
//            Keyframe {
//                frame: 400
//                value: Qt.vector3d(0, -72.0001, 0)
//            }
//            Keyframe {
//                frame: 416.667
//                value: Qt.vector3d(-1.40334e-14, -90.0001, 1.89576e-20)
//            }
//            Keyframe {
//                frame: 433.333
//                value: Qt.vector3d(-1.369e-14, -108, 2.1683e-15)
//            }
//            Keyframe {
//                frame: 466.667
//                value: Qt.vector3d(-1.1141e-14, -144, 5.67665e-15)
//            }
//            Keyframe {
//                frame: 483.333
//                value: Qt.vector3d(-9.18497e-15, -162, 6.67329e-15)
//            }
//            Keyframe {
//                frame: 500
//                value: Qt.vector3d(-7.01669e-15, 180, 7.01671e-15)
//            }
//            Keyframe {
//                frame: 533.333
//                value: Qt.vector3d(-2.89237e-15, 144, 5.67662e-15)
//            }
//            Keyframe {
//                frame: 550
//                value: Qt.vector3d(-1.34006e-15, 126, 4.12431e-15)
//            }
//            Keyframe {
//                frame: 566.667
//                value: Qt.vector3d(-3.43415e-16, 108, 2.16826e-15)
//            }
//            Keyframe {
//                frame: 600
//                value: Qt.vector3d(0, 71.9999, 0)
//            }
//            Keyframe {
//                frame: 616.667
//                value: Qt.vector3d(0, 53.9999, 0)
//            }
//            Keyframe {
//                frame: 633.333
//                value: Qt.vector3d(0, 35.9999, 0)
//            }
//            Keyframe {
//                frame: 666.667
//                value: Qt.vector3d(0, -6.10352e-05, 0)
//            }
//            Keyframe {
//                frame: 683.333
//                value: Qt.vector3d(0, -18, 0)
//            }
//            Keyframe {
//                frame: 700
//                value: Qt.vector3d(0, -35.9999, 0)
//            }
//            Keyframe {
//                frame: 733.333
//                value: Qt.vector3d(0, -71.9999, 0)
//            }
//            Keyframe {
//                frame: 750
//                value: Qt.vector3d(0, -89.9999, 0)
//            }
//            Keyframe {
//                frame: 766.667
//                value: Qt.vector3d(-1.369e-14, -108, 2.16827e-15)
//            }
//            Keyframe {
//                frame: 800
//                value: Qt.vector3d(-1.1141e-14, -144, 5.67663e-15)
//            }
//            Keyframe {
//                frame: 816.667
//                value: Qt.vector3d(-9.18501e-15, -162, 6.67328e-15)
//            }
//            Keyframe {
//                frame: 833.333
//                value: Qt.vector3d(-7.01673e-15, -180, 7.01671e-15)
//            }
//            Keyframe {
//                frame: 866.667
//                value: Qt.vector3d(-2.89241e-15, 144, 5.67665e-15)
//            }
//            Keyframe {
//                frame: 883.333
//                value: Qt.vector3d(-1.34008e-15, 126, 4.12433e-15)
//            }
//            Keyframe {
//                frame: 900
//                value: Qt.vector3d(-3.43429e-16, 108, 2.1683e-15)
//            }
//            Keyframe {
//                frame: 933.333
//                value: Qt.vector3d(0, 72.0002, 0)
//            }
//            Keyframe {
//                frame: 950
//                value: Qt.vector3d(0, 54.0002, 0)
//            }
//            Keyframe {
//                frame: 966.667
//                value: Qt.vector3d(0, 36.0004, 0)
//            }
//            Keyframe {
//                frame: 983.333
//                value: Qt.vector3d(0, 18.0002, 0)
//            }
//            Keyframe {
//                frame: 1000
//                value: Qt.vector3d(0, 4.21003e-14, 0)
//            }
//        }

//        KeyframeGroup {
//            target: aW101_propellar
//            property: "scale"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(1, 1, 1)
//            }
//        }
//    }

}
