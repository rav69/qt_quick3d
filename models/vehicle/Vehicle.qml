import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: desert_Patrol_Vehicle_fbx
        eulerRotation.x: 90
        scale.x: 0.01
        scale.y: 0.01
        scale.z: 0.01

        Node {
            id: rootNode

            Node {
                id: dPV_main01
                x: -22.826
                y: -3.17796
                z: 44.3709
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main01_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main01_xxxxx__EnvMapColormapGloss_0.mesh"

                    PrincipledMaterial {
                        id: xxxxxEnvMapColormapGloss_material
                        baseColorMap: Texture {
                            source: "maps/0.png"
                            tilingModeHorizontal: Texture.Repeat
                            tilingModeVertical: Texture.Repeat
                        }
                        opacityChannel: Material.A
                        metalness: 0
                        roughness: 0.930075
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main02
                x: -22.826
                y: -3.17796
                z: 44.3709
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main02_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main02_xxxxx__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main03
                x: 102.257
                y: 251.447
                z: -236.328
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main03_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main03_xxxxx__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main04
                x: 35.4019
                y: 149.176
                z: 90.3028
                eulerRotation.x: 23.5072
                scale.x: 4.37793
                scale.y: 4.37792
                scale.z: 4.37792

                Model {
                    id: dPV_main04_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main04_xxxxx__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main05
                x: 151.925
                y: 67.7969
                z: -170.025
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main05_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main05_xxxxx__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main06
                x: 147.189
                y: 67.7969
                z: 316.06
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main06_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main06_xxxxx__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main07
                x: -197.466
                y: 67.7948
                z: -170.026
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main07_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main07_xxxxx__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main08
                x: -197.491
                y: 67.7969
                z: 316.062
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main08_xxxxx__EnvMapColormapGloss_0
                    source: "meshes/dPV_main08_xxxxx__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxxxEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: dPV_main09
                x: -22.826
                y: 166.039
                z: -276.11
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: dPV_main09_Alpha__Alpha_0
                    source: "meshes/dPV_main09_Alpha__Alpha_0.mesh"

                    PrincipledMaterial {
                        id: alphaAlpha_material
                        baseColor: "#ff969696"
                        metalness: 0
                        roughness: 0.930075
                        emissiveColor: "#ffffffff"
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        alphaAlpha_material
                    ]
                }
            }

            Node {
                id: lightsOFF01
                x: -22.8545
                y: 126.174
                z: 395.313
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: lightsOFF01_Alpha__Alpha_0
                    source: "meshes/lightsOFF01_Alpha__Alpha_0.mesh"
                    materials: [
                        alphaAlpha_material
                    ]
                }
            }

            Node {
                id: lightsOFF02
                x: -22.826
                y: 166.039
                z: -276.11
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: lightsOFF02_Alpha__Alpha_0
                    source: "meshes/lightsOFF02_Alpha__Alpha_0.mesh"
                    materials: [
                        alphaAlpha_material
                    ]
                }
            }

            Node {
                id: lightsON_M
                x: -22.8545
                y: 126.174
                z: 395.313
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: lightsON_M_Alpha__Alpha_0
                    source: "meshes/lightsON_M_Alpha__Alpha_0.mesh"
                    materials: [
                        alphaAlpha_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_Combined01
                x: -22.3099
                y: 291.381
                z: -41.0788
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_Combined01_xxxx45x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_Combined01_xxxx45x__EnvMapColormapGloss_0.mesh"

                    PrincipledMaterial {
                        id: xxxx45xEnvMapColormapGloss_material
                        baseColorMap: Texture {
                            source: "maps/1.png"
                            tilingModeHorizontal: Texture.Repeat
                            tilingModeVertical: Texture.Repeat
                        }
                        opacityChannel: Material.A
                        metalness: 0
                        roughness: 0.930075
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        xxxx45xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_Combined02
                x: -22.7706
                y: 258.443
                z: -27.0321
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_Combined02_xxxx45x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_Combined02_xxxx45x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx45xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat01
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat01_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat01_xxxx444x__EnvMapColormapGloss_0.mesh"

                    PrincipledMaterial {
                        id: xxxx444xEnvMapColormapGloss_material
                        baseColorMap: Texture {
                            source: "maps/2.png"
                            tilingModeHorizontal: Texture.Repeat
                            tilingModeVertical: Texture.Repeat
                        }
                        opacityChannel: Material.A
                        metalness: 0
                        roughness: 0.930075
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat02
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat02_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat02_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat03
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat03_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat03_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat04
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat04_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat04_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat05
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat05_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat05_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat06
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat06_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat06_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat07
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat07_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat07_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat08
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat08_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat08_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat09
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat09_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat09_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat10
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat10_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat10_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat11
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat11_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat11_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat12
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat12_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat12_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat13
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat13_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat13_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: mK19_WAR_Combined_mk19_ammo_mat14
                x: 12.7555
                y: 312.616
                z: -34.2524
                eulerRotation.x: 2.50448e-06
                eulerRotation.y: -1.43935e-13
                eulerRotation.z: -90
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: mK19_WAR_Combined_mk19_ammo_mat14_xxxx444x__EnvMapColormapGloss_0
                    source: "meshes/mK19_WAR_Combined_mk19_ammo_mat14_xxxx444x__EnvMapColormapGloss_0.mesh"
                    materials: [
                        xxxx444xEnvMapColormapGloss_material
                    ]
                }
            }

            Node {
                id: fence
                x: -22.826
                y: -3.17796
                z: 44.3709
                eulerRotation.x: -4.32571e-06
                scale.x: 4.37793
                scale.y: 4.37793
                scale.z: 4.37793

                Model {
                    id: fence_xxx4x__EnvMapColormapGloss_0
                    source: "meshes/fence_xxx4x__EnvMapColormapGloss_0.mesh"

                    PrincipledMaterial {
                        id: xxx4xEnvMapColormapGloss_material
                        baseColorMap: Texture {
                            source: "maps/3.png"
                            tilingModeHorizontal: Texture.Repeat
                            tilingModeVertical: Texture.Repeat
                        }
                        opacityChannel: Material.A
                        metalness: 0
                        roughness: 0.930075
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        xxx4xEnvMapColormapGloss_material
                    ]
                }
            }
        }
    }
}
