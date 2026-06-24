import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: f_117_obj_cleaner_materialmerger_gles

        Model {
            id: object_2
            source: "meshes/object_2.mesh"

            PrincipledMaterial {
                id: node323851f7_9aff_42e4_a630_ec0095ceb8ae_material
                baseColorMap: Texture {
                    source: "maps/0.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalnessMap: Texture {
                    source: "maps/1.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                metalnessChannel: Material.B
                roughnessMap: Texture {
                    source: "maps/1.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                roughnessChannel: Material.G
                roughness: 0.4
                normalMap: Texture {
                    source: "maps/2.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionMap: Texture {
                    source: "maps/1.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionChannel: Material.R
                emissiveMap: Texture {
                    source: "maps/0.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                emissiveColor: "#ff808080"
                cullMode: Material.NoCulling
            }
            materials: [
                node323851f7_9aff_42e4_a630_ec0095ceb8ae_material
            ]
        }

        Model {
            id: object_3
            source: "meshes/object_3.mesh"

            PrincipledMaterial {
                id: node593b16f6_0281_4de8_973d_7df2624ddeab_material
                baseColorMap: Texture {
                    source: "maps/3.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalnessMap: Texture {
                    source: "maps/4.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                metalnessChannel: Material.B
                roughnessMap: Texture {
                    source: "maps/4.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                roughnessChannel: Material.G
                roughness: 0.4
                normalMap: Texture {
                    source: "maps/5.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionMap: Texture {
                    source: "maps/4.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionChannel: Material.R
                emissiveMap: Texture {
                    source: "maps/3.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                emissiveColor: "#ff404040"
                cullMode: Material.NoCulling
            }
            materials: [
                node593b16f6_0281_4de8_973d_7df2624ddeab_material
            ]
        }

        Model {
            id: object_4
            source: "meshes/object_4.mesh"

            PrincipledMaterial {
                id: node76cf964d_16de_4633_b439_e4c4d028e99f_material
                baseColor: "#80000000"
                metalness: 0
                roughness: 0.1
                cullMode: Material.NoCulling
                alphaMode: PrincipledMaterial.Blend
            }
            materials: [
                node76cf964d_16de_4633_b439_e4c4d028e99f_material
            ]
        }

        Model {
            id: object_5
            source: "meshes/object_5.mesh"

            PrincipledMaterial {
                id: node80aa9aa0_3ef6_42d2_b3f8_a3480b7b7b1f_material
                baseColorMap: Texture {
                    source: "maps/6.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalnessMap: Texture {
                    source: "maps/7.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                metalnessChannel: Material.B
                roughnessMap: Texture {
                    source: "maps/7.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                roughnessChannel: Material.G
                roughness: 0.4
                normalMap: Texture {
                    source: "maps/8.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionMap: Texture {
                    source: "maps/7.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionChannel: Material.R
                emissiveMap: Texture {
                    source: "maps/6.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                emissiveColor: "#ffffffff"
                cullMode: Material.NoCulling
            }
            materials: [
                node80aa9aa0_3ef6_42d2_b3f8_a3480b7b7b1f_material
            ]
        }

        Model {
            id: object_6
            source: "meshes/object_6.mesh"
            materials: [
                node80aa9aa0_3ef6_42d2_b3f8_a3480b7b7b1f_material
            ]
        }

        Model {
            id: object_7
            source: "meshes/object_7.mesh"
            materials: [
                node80aa9aa0_3ef6_42d2_b3f8_a3480b7b7b1f_material
            ]
        }

        Model {
            id: object_8
            source: "meshes/object_8.mesh"

            PrincipledMaterial {
                id: node9275bc17_21b0_42b2_b3f3_501cd37cd6c7_material
                baseColor: "#4d000000"
                metalness: 0
                roughness: 0.1
                emissiveColor: "#ff1a1a1a"
                cullMode: Material.NoCulling
                alphaMode: PrincipledMaterial.Blend
            }
            materials: [
                node9275bc17_21b0_42b2_b3f3_501cd37cd6c7_material
            ]
        }

        Model {
            id: object_9
            source: "meshes/object_9.mesh"

            PrincipledMaterial {
                id: c064e974_80f8_4f65_bb0f_c08cb9f818b4_material
                baseColorMap: Texture {
                    source: "maps/9.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalnessMap: Texture {
                    source: "maps/10.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                metalnessChannel: Material.B
                roughnessMap: Texture {
                    source: "maps/10.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                roughnessChannel: Material.G
                roughness: 0.4
                normalMap: Texture {
                    source: "maps/11.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionMap: Texture {
                    source: "maps/10.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionChannel: Material.R
                emissiveMap: Texture {
                    source: "maps/9.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                emissiveColor: "#ff404040"
                cullMode: Material.NoCulling
            }
            materials: [
                c064e974_80f8_4f65_bb0f_c08cb9f818b4_material
            ]
        }

        Model {
            id: object_10
            source: "meshes/object_10.mesh"

            PrincipledMaterial {
                id: node51911afb_3794_4a57_9662_20c7bbeb154d_material
                baseColorMap: Texture {
                    source: "maps/12.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalnessMap: Texture {
                    source: "maps/13.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                metalnessChannel: Material.B
                roughnessMap: Texture {
                    source: "maps/13.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                roughnessChannel: Material.G
                roughness: 0.5
                normalMap: Texture {
                    source: "maps/14.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionMap: Texture {
                    source: "maps/13.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionChannel: Material.R
                emissiveMap: Texture {
                    source: "maps/12.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                emissiveColor: "#ff808080"
                cullMode: Material.NoCulling
            }
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_11
            source: "meshes/object_11.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_12
            source: "meshes/object_12.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_13
            source: "meshes/object_13.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_14
            source: "meshes/object_14.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_15
            source: "meshes/object_15.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_16
            source: "meshes/object_16.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_17
            source: "meshes/object_17.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_18
            source: "meshes/object_18.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_19
            source: "meshes/object_19.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_20
            source: "meshes/object_20.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_21
            source: "meshes/object_21.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_22
            source: "meshes/object_22.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_23
            source: "meshes/object_23.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_24
            source: "meshes/object_24.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_25
            source: "meshes/object_25.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_26
            source: "meshes/object_26.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_27
            source: "meshes/object_27.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_28
            source: "meshes/object_28.mesh"
            materials: [
                node51911afb_3794_4a57_9662_20c7bbeb154d_material
            ]
        }

        Model {
            id: object_29
            source: "meshes/object_29.mesh"

            PrincipledMaterial {
                id: e5705c80_1fda_4427_adf1_f871f5ec252c_material
                baseColorMap: Texture {
                    source: "maps/15.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalnessMap: Texture {
                    source: "maps/16.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                metalnessChannel: Material.B
                roughnessMap: Texture {
                    source: "maps/16.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                roughnessChannel: Material.G
                roughness: 0.4
                normalMap: Texture {
                    source: "maps/17.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionMap: Texture {
                    source: "maps/16.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionChannel: Material.R
                emissiveMap: Texture {
                    source: "maps/15.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                emissiveColor: "#ff808080"
                cullMode: Material.NoCulling
            }
            materials: [
                e5705c80_1fda_4427_adf1_f871f5ec252c_material
            ]
        }

        Model {
            id: object_30
            source: "meshes/object_30.mesh"
            materials: [
                e5705c80_1fda_4427_adf1_f871f5ec252c_material
            ]
        }
    }
}
