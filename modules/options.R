##### Options module ##############################################################################################################

# Last modified by Julian Mann (22/09/2021)
# - JM (22/09/2021):  Commented out options 4-10 to speed up app running for testing purposes
# - JM (22/09/2021):  Added returned reactiveValues output for pre-construction and embodied carbon to be passed to roadsummary submodule
# - JM (22/09/2021):  commented out road and rail options 4-10 to speed up app for build/test purposes

###################################################################################################################################


options_ui <- function(id){ # module could be kept in separate R file
  ns <- NS(id)
  ### tabItems now produced in module, submodules separated by comma
  tabItems( # can these be looped over, or use do.call??
    
    intro_ui(ns("Intro1"), tabName = "Intro1"),
    
    proj_details_ui(ns("Proj1"), tabName = "Proj1"),
    
    scoping_ui(ns("Scoping1"), tabName = "Scoping1"),
    
    ### Road UI ###
    
    roadhome_ui(ns("RoadHome"), tabName = "RoadHome"),
    
    baseline_ui(ns("baselinero1"), tabName = "baselinero1"),
    preconst_ui(ns("preconstro1"), tabName = "preconstro1"),
    embcarbon_ui(ns("embcarbonro1"), tabName = "embcarbonro1"),
    const_ui(ns("constro1"), tabName = "constro1"),
    use_ui(ns("usero1"), tabName = "usero1"),
    useremis_ui(ns("useremisro1"), tabName = "useremisro1"),
    maint_ui(ns("maintro1"), tabName = "maintro1"),
    eolife_ui(ns("eolifero1"), tabName = "eolifero1"),
    
    baseline_ui(ns("baselinero2"), tabName = "baselinero2"),
    preconst_ui(ns("preconstro2"), tabName = "preconstro2"),
    embcarbon_ui(ns("embcarbonro2"), tabName = "embcarbonro2"),
    const_ui(ns("constro2"), tabName = "constro2"),
    use_ui(ns("usero2"), tabName = "usero2"),
    useremis_ui(ns("useremisro2"), tabName = "useremisro2"),
    maint_ui(ns("maintro2"), tabName = "maintro2"),
    eolife_ui(ns("eolifero2"), tabName = "eolifero2"),
    
    baseline_ui(ns("baselinero3"), tabName = "baselinero3"),
    preconst_ui(ns("preconstro3"), tabName = "preconstro3"),
    embcarbon_ui(ns("embcarbonro3"), tabName = "embcarbonro3"),
    const_ui(ns("constro3"), tabName = "constro3"),
    use_ui(ns("usero3"), tabName = "usero3"),
    useremis_ui(ns("useremisro3"), tabName = "useremisro3"),
    maint_ui(ns("maintro3"), tabName = "maintro3"),
    eolife_ui(ns("eolifero3"), tabName = "eolifero3"),
    
    baseline_ui(ns("baselinero4"), tabName = "baselinero4"),
    preconst_ui(ns("preconstro4"), tabName = "preconstro4"),
    embcarbon_ui(ns("embcarbonro4"), tabName = "embcarbonro4"),
    const_ui(ns("constro4"), tabName = "constro4"),
    use_ui(ns("usero4"), tabName = "usero4"),
    useremis_ui(ns("useremisro4"), tabName = "useremisro4"),
    maint_ui(ns("maintro4"), tabName = "maintro4"),
    eolife_ui(ns("eolifero4"), tabName = "eolifero4"),

    baseline_ui(ns("baselinero5"), tabName = "baselinero5"),
    preconst_ui(ns("preconstro5"), tabName = "preconstro5"),
    embcarbon_ui(ns("embcarbonro5"), tabName = "embcarbonro5"),
    const_ui(ns("constro5"), tabName = "constro5"),
    use_ui(ns("usero5"), tabName = "usero5"),
    useremis_ui(ns("useremisro5"), tabName = "useremisro5"),
    maint_ui(ns("maintro5"), tabName = "maintro5"),
    eolife_ui(ns("eolifero5"), tabName = "eolifero5"),
    
    baseline_ui(ns("baselinero6"), tabName = "baselinero6"),
    preconst_ui(ns("preconstro6"), tabName = "preconstro6"),
    embcarbon_ui(ns("embcarbonro6"), tabName = "embcarbonro6"),
    const_ui(ns("constro6"), tabName = "constro6"),
    use_ui(ns("usero6"), tabName = "usero6"),
    useremis_ui(ns("useremisro6"), tabName = "useremisro6"),
    maint_ui(ns("maintro6"), tabName = "maintro6"),
    eolife_ui(ns("eolifero6"), tabName = "eolifero6"),
    
    baseline_ui(ns("baselinero7"), tabName = "baselinero7"),
    preconst_ui(ns("preconstro7"), tabName = "preconstro7"),
    embcarbon_ui(ns("embcarbonro7"), tabName = "embcarbonro7"),
    const_ui(ns("constro7"), tabName = "constro7"),
    use_ui(ns("usero7"), tabName = "usero7"),
    useremis_ui(ns("useremisro7"), tabName = "useremisro7"),
    maint_ui(ns("maintro7"), tabName = "maintro7"),
    eolife_ui(ns("eolifero7"), tabName = "eolifero7"),
    
    baseline_ui(ns("baselinero8"), tabName = "baselinero8"),
    preconst_ui(ns("preconstro8"), tabName = "preconstro8"),
    embcarbon_ui(ns("embcarbonro8"), tabName = "embcarbonro8"),
    const_ui(ns("constro8"), tabName = "constro8"),
    use_ui(ns("usero8"), tabName = "usero8"),
    useremis_ui(ns("useremisro8"), tabName = "useremisro8"),
    maint_ui(ns("maintro8"), tabName = "maintro8"),
    eolife_ui(ns("eolifero8"), tabName = "eolifero8"),
    
    # baseline_ui(ns("baselinero9"), tabName = "baselinero9"),
    # preconst_ui(ns("preconstro9"), tabName = "preconstro9"),
    # embcarbon_ui(ns("embcarbonro9"), tabName = "embcarbonro9"),
    # const_ui(ns("constro9"), tabName = "constro9"),
    # use_ui(ns("usero9"), tabName = "usero9"),
    # useremis_ui(ns("useremisro9"), tabName = "useremisro9"),
    # maint_ui(ns("maintro9"), tabName = "maintro9"),
    # eolife_ui(ns("eolifero9"), tabName = "eolifero9"),
    # 
    # baseline_ui(ns("baselinero10"), tabName = "baselinero10"),
    # preconst_ui(ns("preconstro10"), tabName = "preconstro10"),
    # embcarbon_ui(ns("embcarbonro10"), tabName = "embcarbonro10"),
    # const_ui(ns("constro10"), tabName = "constro10"),
    # use_ui(ns("usero10"), tabName = "usero10"),
    # useremis_ui(ns("useremisro10"), tabName = "useremisro10"),
    # maint_ui(ns("maintro10"), tabName = "maintro10"),
    # eolife_ui(ns("eolifero10"), tabName = "eolifero10"),
    
    roadsummary_ui(ns("RoadSummary"), tabName = "RoadSummary", road_home_icon),

    ### Rail UI ###
    
    roadhome_ui(ns("RailHome"), tabName = "RailHome"),
    
    baseline_ui(ns("baselinera1"), tabName = "baselinera1"),
    preconst_ui(ns("preconstra1"), tabName = "preconstra1"),
    embcarbon_ui(ns("embcarbonra1"), tabName = "embcarbonra1"),
    const_ui(ns("constra1"), tabName = "constra1"),
    use_ui(ns("usera1"), tabName = "usera1"),
    useremisrail_ui(ns("useremisra1"), tabName = "useremisra1"),
    maint_ui(ns("maintra1"), tabName = "maintra1"),
    eolife_ui(ns("eolifera1"), tabName = "eolifera1"),
    
    baseline_ui(ns("baselinera2"), tabName = "baselinera2"),
    preconst_ui(ns("preconstra2"), tabName = "preconstra2"),
    embcarbon_ui(ns("embcarbonra2"), tabName = "embcarbonra2"),
    const_ui(ns("constra2"), tabName = "constra2"),
    use_ui(ns("usera2"), tabName = "usera2"),
    useremisrail_ui(ns("useremisra2"), tabName = "useremisra2"),
    maint_ui(ns("maintra2"), tabName = "maintra2"),
    eolife_ui(ns("eolifera2"), tabName = "eolifera2"),
    
    baseline_ui(ns("baselinera3"), tabName = "baselinera3"),
    preconst_ui(ns("preconstra3"), tabName = "preconstra3"),
    embcarbon_ui(ns("embcarbonra3"), tabName = "embcarbonra3"),
    const_ui(ns("constra3"), tabName = "constra3"),
    use_ui(ns("usera3"), tabName = "usera3"),
    useremisrail_ui(ns("useremisra3"), tabName = "useremisra3"),
    maint_ui(ns("maintra3"), tabName = "maintra3"),
    eolife_ui(ns("eolifera3"), tabName = "eolifera3"),
    
    baseline_ui(ns("baselinera4"), tabName = "baselinera4"),
    preconst_ui(ns("preconstra4"), tabName = "preconstra4"),
    embcarbon_ui(ns("embcarbonra4"), tabName = "embcarbonra4"),
    const_ui(ns("constra4"), tabName = "constra4"),
    use_ui(ns("usera4"), tabName = "usera4"),
    useremisrail_ui(ns("useremisra4"), tabName = "useremisra4"),
    maint_ui(ns("maintra4"), tabName = "maintra4"),
    eolife_ui(ns("eolifera4"), tabName = "eolifera4"),

    baseline_ui(ns("baselinera5"), tabName = "baselinera5"),
    preconst_ui(ns("preconstra5"), tabName = "preconstra5"),
    embcarbon_ui(ns("embcarbonra5"), tabName = "embcarbonra5"),
    const_ui(ns("constra5"), tabName = "constra5"),
    use_ui(ns("usera5"), tabName = "usera5"),
    useremisrail_ui(ns("useremisra5"), tabName = "useremisra5"),
    maint_ui(ns("maintra5"), tabName = "maintra5"),
    eolife_ui(ns("eolifera5"), tabName = "eolifera5"),
    
    baseline_ui(ns("baselinera6"), tabName = "baselinera6"),
    preconst_ui(ns("preconstra6"), tabName = "preconstra6"),
    embcarbon_ui(ns("embcarbonra6"), tabName = "embcarbonra6"),
    const_ui(ns("constra6"), tabName = "constra6"),
    use_ui(ns("usera6"), tabName = "usera6"),
    useremisrail_ui(ns("useremisra6"), tabName = "useremisra6"),
    maint_ui(ns("maintra6"), tabName = "maintra6"),
    eolife_ui(ns("eolifera6"), tabName = "eolifera6"),
    
    baseline_ui(ns("baselinera7"), tabName = "baselinera7"),
    preconst_ui(ns("preconstra7"), tabName = "preconstra7"),
    embcarbon_ui(ns("embcarbonra7"), tabName = "embcarbonra7"),
    const_ui(ns("constra7"), tabName = "constra7"),
    use_ui(ns("usera7"), tabName = "usera7"),
    useremisrail_ui(ns("useremisra7"), tabName = "useremisra7"),
    maint_ui(ns("maintra7"), tabName = "maintra7"),
    eolife_ui(ns("eolifera7"), tabName = "eolifera7"),
    
    baseline_ui(ns("baselinera8"), tabName = "baselinera8"),
    preconst_ui(ns("preconstra8"), tabName = "preconstra8"),
    embcarbon_ui(ns("embcarbonra8"), tabName = "embcarbonra8"),
    const_ui(ns("constra8"), tabName = "constra8"),
    use_ui(ns("usera8"), tabName = "usera8"),
    useremisrail_ui(ns("useremisra8"), tabName = "useremisra8"),
    maint_ui(ns("maintra8"), tabName = "maintra8"),
    eolife_ui(ns("eolifera8"), tabName = "eolifera8"),
    
    # baseline_ui(ns("baselinera9"), tabName = "baselinera9"),
    # preconst_ui(ns("preconstra9"), tabName = "preconstra9"),
    # embcarbon_ui(ns("embcarbonra9"), tabName = "embcarbonra9"),
    # const_ui(ns("constra9"), tabName = "constra9"),
    # use_ui(ns("usera9"), tabName = "usera9"),
    # useremisrail_ui(ns("useremisra9"), tabName = "useremisra9"),
    # maint_ui(ns("maintra9"), tabName = "maintra9"),
    # eolife_ui(ns("eolifera9"), tabName = "eolifera9"),
    # 
    # baseline_ui(ns("baselinera10"), tabName = "baselinera10"),
    # preconst_ui(ns("preconstra10"), tabName = "preconstra10"),
    # embcarbon_ui(ns("embcarbonra10"), tabName = "embcarbonra10"),
    # const_ui(ns("constra10"), tabName = "constra10"),
    # use_ui(ns("usera10"), tabName = "usera10"),
    # useremisrail_ui(ns("useremisra10"), tabName = "useremisra10"),
    # maint_ui(ns("maintra10"), tabName = "maintra10"),
    # eolife_ui(ns("eolifera10"), tabName = "eolifera10"),
    
    roadsummary_ui(ns("RailSummary"), tabName = "RailSummary", rail_home_icon),
    
    ### Greenway UI ###
    
    roadhome_ui(ns("GreenwayHome"), tabName = "GreenwayHome"),
    baseline_ui(ns("baselinegw1"), tabName = "baselinegw1"),
    preconst_ui(ns("preconstgw1"), tabName = "preconstgw1"),
    embcarbon_ui(ns("embcarbongw1"), tabName = "embcarbongw1"),
    const_ui(ns("constgw1"), tabName = "constgw1"),
    use_ui(ns("usegw1"), tabName = "usegw1"),
    useremisgreen_ui(ns("useremisgw1"), tabName = "useremisgw1"),
    maint_ui(ns("maintgw1"), tabName = "maintgw1"),
    eolife_ui(ns("eolifegw1"), tabName = "eolifegw1"),
    
    baseline_ui(ns("baselinegw2"), tabName = "baselinegw2"),
    preconst_ui(ns("preconstgw2"), tabName = "preconstgw2"),
    embcarbon_ui(ns("embcarbongw2"), tabName = "embcarbongw2"),
    const_ui(ns("constgw2"), tabName = "constgw2"),
    use_ui(ns("usegw2"), tabName = "usegw2"),
    useremisgreen_ui(ns("useremisgw2"), tabName = "useremisgw2"),
    maint_ui(ns("maintgw2"), tabName = "maintgw2"),
    eolife_ui(ns("eolifegw2"), tabName = "eolifegw2"),
    
    baseline_ui(ns("baselinegw3"), tabName = "baselinegw3"),
    preconst_ui(ns("preconstgw3"), tabName = "preconstgw3"),
    embcarbon_ui(ns("embcarbongw3"), tabName = "embcarbongw3"),
    const_ui(ns("constgw3"), tabName = "constgw3"),
    use_ui(ns("usegw3"), tabName = "usegw3"),
    useremisgreen_ui(ns("useremisgw3"), tabName = "useremisgw3"),
    maint_ui(ns("maintgw3"), tabName = "maintgw3"),
    eolife_ui(ns("eolifegw3"), tabName = "eolifegw3"),
    
    baseline_ui(ns("baselinegw4"), tabName = "baselinegw4"),
    preconst_ui(ns("preconstgw4"), tabName = "preconstgw4"),
    embcarbon_ui(ns("embcarbongw4"), tabName = "embcarbongw4"),
    const_ui(ns("constgw4"), tabName = "constgw4"),
    use_ui(ns("usegw4"), tabName = "usegw4"),
    useremisgreen_ui(ns("useremisgw4"), tabName = "useremisgw4"),
    maint_ui(ns("maintgw4"), tabName = "maintgw4"),
    eolife_ui(ns("eolifegw4"), tabName = "eolifegw4"),
    
    baseline_ui(ns("baselinegw5"), tabName = "baselinegw5"),
    preconst_ui(ns("preconstgw5"), tabName = "preconstgw5"),
    embcarbon_ui(ns("embcarbongw5"), tabName = "embcarbongw5"),
    const_ui(ns("constgw5"), tabName = "constgw5"),
    use_ui(ns("usegw5"), tabName = "usegw5"),
    useremisgreen_ui(ns("useremisgw5"), tabName = "useremisgw5"),
    maint_ui(ns("maintgw5"), tabName = "maintgw5"),
    eolife_ui(ns("eolifegw5"), tabName = "eolifegw5"),
    
    baseline_ui(ns("baselinegw6"), tabName = "baselinegw6"),
    preconst_ui(ns("preconstgw6"), tabName = "preconstgw6"),
    embcarbon_ui(ns("embcarbongw6"), tabName = "embcarbongw6"),
    const_ui(ns("constgw6"), tabName = "constgw6"),
    use_ui(ns("usegw6"), tabName = "usegw6"),
    useremisgreen_ui(ns("useremisgw6"), tabName = "useremisgw6"),
    maint_ui(ns("maintgw6"), tabName = "maintgw6"),
    eolife_ui(ns("eolifegw6"), tabName = "eolifegw6"),
    
    baseline_ui(ns("baselinegw7"), tabName = "baselinegw7"),
    preconst_ui(ns("preconstgw7"), tabName = "preconstgw7"),
    embcarbon_ui(ns("embcarbongw7"), tabName = "embcarbongw7"),
    const_ui(ns("constgw7"), tabName = "constgw7"),
    use_ui(ns("usegw7"), tabName = "usegw7"),
    useremisgreen_ui(ns("useremisgw7"), tabName = "useremisgw7"),
    maint_ui(ns("maintgw7"), tabName = "maintgw7"),
    eolife_ui(ns("eolifegw7"), tabName = "eolifegw7"),
    
    baseline_ui(ns("baselinegw8"), tabName = "baselinegw8"),
    preconst_ui(ns("preconstgw8"), tabName = "preconstgw8"),
    embcarbon_ui(ns("embcarbongw8"), tabName = "embcarbongw8"),
    const_ui(ns("constgw8"), tabName = "constgw8"),
    use_ui(ns("usegw8"), tabName = "usegw8"),
    useremisgreen_ui(ns("useremisgw8"), tabName = "useremisgw8"),
    maint_ui(ns("maintgw8"), tabName = "maintgw8"),
    eolife_ui(ns("eolifegw8"), tabName = "eolifegw8"),
    
    # baseline_ui(ns("baselinegw9"), tabName = "baselinegw9"),
    # preconst_ui(ns("preconstgw9"), tabName = "preconstgw9"),
    # embcarbon_ui(ns("embcarbongw9"), tabName = "embcarbongw9"),
    # const_ui(ns("constgw9"), tabName = "constgw9"),
    # use_ui(ns("usegw9"), tabName = "usegw9"),
    # useremisgreen_ui(ns("useremisgw9"), tabName = "useremisgw9"),
    # maint_ui(ns("maintgw9"), tabName = "maintgw9"),
    # eolife_ui(ns("eolifegw9"), tabName = "eolifegw9"),
    # 
    # baseline_ui(ns("baselinegw10"), tabName = "baselinegw10"),
    # preconst_ui(ns("preconstgw10"), tabName = "preconstgw10"),
    # embcarbon_ui(ns("embcarbongw10"), tabName = "embcarbongw10"),
    # const_ui(ns("constgw10"), tabName = "constgw10"),
    # use_ui(ns("usegw10"), tabName = "usegw10"),
    # useremisgreen_ui(ns("useremisgw10"), tabName = "useremisgw10"),
    # maint_ui(ns("maintgw10"), tabName = "maintgw10"),
    # eolife_ui(ns("eolifegw10"), tabName = "eolifegw10"),
    
    roadsummary_ui(ns("GreenwaySummary"), tabName = "GreenwaySummary", gway_home_icon),
    
    eflibrary_ui(ns("EFlibrary"), tabName = "EFlibrary"),
    ccontrol_ui(ns("CControl"), tabName = "CControl") 
    #addcustomef_ui(ns("addcustomEFs"), tabName = "addcustomEFs")
    
  )
}

options_server <- function(id, appR_returned, efs_react, efs_materialroad_userinput, efs_materialrail_userinput){
  
  cat(file=stderr(), paste0(Sys.time()," *** options_server:", "**** \n"))
  
  returned_Ops <- reactiveValues()
  
  cat(file=stderr(), paste0(Sys.time()," *** returned_Ops:", "**** \n"))
  
  moduleServer(id,
               function(input, output, session){
                 
                 cat(file=stderr(), paste0(Sys.time()," *** start moduleServer:",session$token, "**** \n"))
                 
                 intro_server("Intro1","Introduction")
                 
                 cat(file=stderr(), paste0(Sys.time()," *** intro_server:",session$token, "**** \n"))
                 
                 projectdetails_values <- proj_details_server("Proj1", "Project Details", appR_returned) # set this up so can take project details values into other mods
                 cat(file=stderr(), paste0(Sys.time()," *** projectdetails_values:",session$token, "**** \n"))
                 
                 scoping_server("Scoping1", "Scoping", appR_returned)
                 cat(file=stderr(), paste0(Sys.time()," *** scoping_server:",session$token, "**** \n"))
                 
                 ###################################################
                 ##### ROAD SERVER #################################
                 ###################################################
                 
                 
                 RoadHome_serv <- roadhome_server("RoadHome", "Road Home", appR_returned, projectdetails_values)
                 
                 cat(file=stderr(), paste0(Sys.time()," *** RoadHome_serv:",session$token, "**** \n"))
                 
                 baseline_server("baselinero1",1,"Baseline Road Option 1","Baseline 1", appR_returned)
                 preconstro1_serv <- preconst_server("preconstro1",1,"Pre-Construction Road Option 1","Pre-Construction 1", appR_returned) # return reactiveValues output data frame
                 embcarbonro1_serv <- embcarbon_server("embcarbonro1",1,"Embodied Carbon Road Option 1","Embodied Carbon 1", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constro1_serv <- const_server("constro1",1,"Construction Road Option 1","Construction 1", appR_returned)
                 usero1_serv <- use_server("usero1",1,"Operational Use Road Option 1","Use 1", appR_returned, projectdetails_values)
                 useremisro1_serv <- useremis_server("useremisro1",1,"Road User Emissions Option 1","User Emissions 1", appR_returned, projectdetails_values)
                 maintro1_serv <- maint_server("maintro1",1,"Maintenance Road Option 1","Maintenance 1", appR_returned, projectdetails_values)
                 eolifero1_serv <- eolife_server("eolifero1",1,"End of Life Road Option 1","End of Life 1", appR_returned)
                 
                 baseline_server("baselinero2",2,"Baseline Road Option 2","Baseline 2", appR_returned)
                 preconstro2_serv <- preconst_server("preconstro2",2,"Pre-Construction Road Option 2","Pre-Construction 2", appR_returned)
                 embcarbonro2_serv <- embcarbon_server("embcarbonro2",2,"Embodied Carbon Road Option 2","Embodied Carbon 2", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constro2_serv <- const_server("constro2",2,"Construction Road Option 2","Construction 2", appR_returned)
                 usero2_serv <- use_server("usero2",2,"Operational Use Road Option 2","Use 2", appR_returned, projectdetails_values)
                 useremisro2_serv <- useremis_server("useremisro2",2,"Road User Emissions Option 2","User Emissions 2", appR_returned, projectdetails_values)
                 maintro2_serv <- maint_server("maintro2",2,"Maintenance Road Option 2","Maintenance 2", appR_returned, projectdetails_values)
                 eolifero2_serv <- eolife_server("eolifero2",2,"End of Life Road Option 2","End of Life 2", appR_returned)
                 
                 baseline_server("baselinero3",3,"Baseline Road Option 3","Baseline 3", appR_returned)
                 preconstro3_serv <- preconst_server("preconstro3",3,"Pre-Construction Road Option 3","Pre-Construction 3", appR_returned)
                 embcarbonro3_serv <- embcarbon_server("embcarbonro3",3,"Embodied Carbon Road Option 3","Embodied Carbon 3", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constro3_serv <- const_server("constro3",3,"Construction Road Option 3","Construction 3", appR_returned)
                 usero3_serv <- use_server("usero3",3,"Operational Use Road Option 3","Use 3", appR_returned, projectdetails_values)
                 useremisro3_serv <- useremis_server("useremisro3",3,"Road User Emissions Option 3","User Emissions 3", appR_returned, projectdetails_values)
                 maintro3_serv <- maint_server("maintro3",3,"Maintenance Road Option 3","Maintenance 3", appR_returned, projectdetails_values)
                 eolifero3_serv <- eolife_server("eolifero3",3,"End of Life Road Option 3","End of Life 3", appR_returned)
                 
                 baseline_server("baselinero4",4,"Baseline Road Option 4","Baseline 4", appR_returned)
                 preconstro4_serv <- preconst_server("preconstro4",4,"Pre-Construction Road Option 4","Pre-Construction 4", appR_returned)
                 embcarbonro4_serv <- embcarbon_server("embcarbonro4",4,"Embodied Carbon Road Option 4","Embodied Carbon 4", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constro4_serv <- const_server("constro4",4,"Construction Road Option 4","Construction 4", appR_returned)
                 usero4_serv <- use_server("usero4",4,"Operational Use Road Option 4","Use 4", appR_returned, projectdetails_values)
                 useremisro4_serv <- useremis_server("useremisro4",4,"Road User Emissions Option 4","User Emissions 4", appR_returned, projectdetails_values)
                 maintro4_serv <- maint_server("maintro4",4,"Maintenance Road Option 4","Maintenance 4", appR_returned, projectdetails_values)
                 eolifero4_serv <- eolife_server("eolifero4",4,"End of Life Road Option 4","End of Life 4", appR_returned)

                 baseline_server("baselinero5",5,"Baseline Road Option 5","Baseline 5", appR_returned)
                 preconstro5_serv <- preconst_server("preconstro5",5,"Pre-Construction Road Option 5","Pre-Construction 5", appR_returned)
                 embcarbonro5_serv <- embcarbon_server("embcarbonro5",5,"Embodied Carbon Road Option 5","Embodied Carbon 5", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constro5_serv <- const_server("constro5",5,"Construction Road Option 5","Construction 5", appR_returned)
                 usero5_serv <- use_server("usero5",5,"Operational Use Road Option 5","Use 5", appR_returned, projectdetails_values)
                 useremisro5_serv <- useremis_server("useremisro5",5,"Road User Emissions Option 5","User Emissions 5", appR_returned, projectdetails_values)
                 maintro5_serv <- maint_server("maintro5",5,"Maintenance Road Option 5","Maintenance 5", appR_returned, projectdetails_values)
                 eolifero5_serv <- eolife_server("eolifero5",5,"End of Life Road Option 5","End of Life 5", appR_returned)
                  
                 baseline_server("baselinero6",6,"Baseline Road Option 6","Baseline 6", appR_returned)
                 preconstro6_serv <- preconst_server("preconstro6",6,"Pre-Construction Road Option 6","Pre-Construction 6", appR_returned)
                 embcarbonro6_serv <- embcarbon_server("embcarbonro6",6,"Embodied Carbon Road Option 6","Embodied Carbon 6", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constro6_serv <- const_server("constro6",6,"Construction Road Option 6","Construction 6", appR_returned)
                 usero6_serv <- use_server("usero6",6,"Operational Use Road Option 6","Use 6", appR_returned, projectdetails_values)
                 useremisro6_serv <- useremis_server("useremisro6",6,"Road User Emissions Option 6","User Emissions 6", appR_returned, projectdetails_values)
                 maintro6_serv <- maint_server("maintro6",6,"Maintenance Road Option 6","Maintenance 6", appR_returned, projectdetails_values)
                 eolifero6_serv <- eolife_server("eolifero6",6,"End of Life Road Option 6","End of Life 6", appR_returned)
                 
                 baseline_server("baselinero7",7,"Baseline Road Option 7","Baseline 7", appR_returned)
                 preconstro7_serv <- preconst_server("preconstro7",7,"Pre-Construction Road Option 7","Pre-Construction 7", appR_returned)
                 embcarbonro7_serv <- embcarbon_server("embcarbonro7",7,"Embodied Carbon Road Option 7","Embodied Carbon 7", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constro7_serv <- const_server("constro7",7,"Construction Road Option 7","Construction 7", appR_returned)
                 usero7_serv <- use_server("usero7",7,"Operational Use Road Option 7","Use 7", appR_returned, projectdetails_values)
                 useremisro7_serv <- useremis_server("useremisro7",7,"Road User Emissions Option 7","User Emissions 7", appR_returned, projectdetails_values)
                 maintro7_serv <- maint_server("maintro7",7,"Maintenance Road Option 7","Maintenance 7", appR_returned, projectdetails_values)
                 eolifero7_serv <- eolife_server("eolifero7",7,"End of Life Road Option 7","End of Life 7", appR_returned)
                 
                 baseline_server("baselinero8",8,"Baseline Road Option 8","Baseline 8", appR_returned)
                 preconstro8_serv <- preconst_server("preconstro8",8,"Pre-Construction Road Option 8","Pre-Construction 8", appR_returned)
                 embcarbonro8_serv <- embcarbon_server("embcarbonro8",8,"Embodied Carbon Road Option 8","Embodied Carbon 8", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constro8_serv <- const_server("constro8",8,"Construction Road Option 8","Construction 8", appR_returned)
                 usero8_serv <- use_server("usero8",8,"Operational Use Road Option 8","Use 8", appR_returned, projectdetails_values)
                 useremisro8_serv <- useremis_server("useremisro8",8,"Road User Emissions Option 8","User Emissions 8", appR_returned, projectdetails_values)
                 maintro8_serv <- maint_server("maintro8",8,"Maintenance Road Option 8","Maintenance 8", appR_returned, projectdetails_values)
                 eolifero8_serv <- eolife_server("eolifero8",8,"End of Life Road Option 8","End of Life 8", appR_returned)
                 
                 # baseline_server("baselinero9",9,"Baseline Road Option 9","Baseline 9", appR_returned)
                 # preconstro9_serv <- preconst_server("preconstro9",9,"Pre-Construction Road Option 9","Pre-Construction 9", appR_returned)
                 # embcarbonro9_serv <- embcarbon_server("embcarbonro9",9,"Embodied Carbon Road Option 9","Embodied Carbon 9", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 # constro9_serv <- const_server("constro9",9,"Construction Road Option 9","Construction 9", appR_returned)
                 # usero9_serv <- use_server("usero9",9,"Operational Use Road Option 9","Use 9", appR_returned, projectdetails_values)
                 # useremisro9_serv <- useremis_server("useremisro9",9,"Road User Emissions Option 9","User Emissions 9", appR_returned, projectdetails_values)
                 # maintro9_serv <- maint_server("maintro9",9,"Maintenance Road Option 9","Maintenance 9", appR_returned, projectdetails_values)
                 # eolifero9_serv <- eolife_server("eolifero9",9,"End of Life Road Option 9","End of Life 9", appR_returned)
                 # 
                 # baseline_server("baselinero10",10,"Baseline Road Option 10","Baseline 10", appR_returned)
                 # preconstro10_serv <- preconst_server("preconstro10",10,"Pre-Construction Road Option 10","Pre-Construction 10", appR_returned)
                 # embcarbonro10_serv <- embcarbon_server("embcarbonro10",10,"Embodied Carbon Road Option 10","Embodied Carbon 10", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 # constro10_serv <- const_server("constro10",10,"Construction Road Option 10","Construction 10", appR_returned)
                 # usero10_serv <- use_server("usero10",10,"Operational Use Road Option 10","Use 10", appR_returned, projectdetails_values)
                 # useremisro10_serv <- useremis_server("useremisro10",10,"Road User Emissions Option 10","User Emissions 10", appR_returned, projectdetails_values)
                 # maintro10_serv <- maint_server("maintro10",10,"Maintenance Road Option 10","Maintenance 10", appR_returned, projectdetails_values)
                 # eolifero10_serv <- eolife_server("eolifero10",10,"End of Life Road Option 10","End of Life 10", appR_returned)
                 
                 cat(file=stderr(), paste0(Sys.time()," *** RoadHome_serv options: ",session$token, "**** \n"))
                 
                 ##### REACTIVE EXPRESSIONS TO PASS TO ROAD SUMMARY MODULE #####
                 
                 # detailed embodied carbon reactive to send to roadsummary
                 road_embcarbon_details <- reactive({
                   
                   x <- rbind(embcarbonro1_serv$details, embcarbonro2_serv$details, embcarbonro3_serv$details, embcarbonro4_serv$details, embcarbonro5_serv$details,
                              embcarbonro6_serv$details, embcarbonro7_serv$details, embcarbonro8_serv$details #, embcarbonro9_serv$details, embcarbonro10_serv$details
                              )
                   return(x)
                   
                 })
                 
                 cat(file=stderr(), paste0(Sys.time()," *** road_embcarbon_details:",session$token, "**** \n"))
                 
                 road_carbsaveimp_options <- reactive({
                   x <- rbind(preconstro1_serv$carbsaveimp, preconstro2_serv$carbsaveimp, preconstro3_serv$carbsaveimp, preconstro4_serv$carbsaveimp, preconstro5_serv$carbsaveimp,
                              embcarbonro1_serv$carbsaveimp, embcarbonro2_serv$carbsaveimp, embcarbonro3_serv$carbsaveimp, embcarbonro4_serv$carbsaveimp, embcarbonro5_serv$carbsaveimp,
                              constro1_serv$carbsaveimp, constro2_serv$carbsaveimp, constro3_serv$carbsaveimp, constro4_serv$carbsaveimp, constro5_serv$carbsaveimp,
                              usero1_serv$carbsaveimp, usero2_serv$carbsaveimp, usero3_serv$carbsaveimp, usero4_serv$carbsaveimp, usero5_serv$carbsaveimp,
                              maintro1_serv$carbsaveimp, maintro2_serv$carbsaveimp, maintro3_serv$carbsaveimp, maintro4_serv$carbsaveimp, maintro5_serv$carbsaveimp,
                              useremisro1_serv$carbsaveimp, useremisro2_serv$carbsaveimp, useremisro3_serv$carbsaveimp, useremisro4_serv$carbsaveimp, useremisro5_serv$carbsaveimp,
                              eolifero1_serv$carbsaveimp, eolifero2_serv$carbsaveimp, eolifero3_serv$carbsaveimp, eolifero4_serv$carbsaveimp, eolifero5_serv$carbsaveimp,
                              fill = T) %>%
                     filter(Description != "")
                   return(x)
                 })
                 
                 cat(file=stderr(), paste0(Sys.time()," *** road_carbsaveimp_options:",session$token, "**** \n"))
                 
                 road_carbsavenotimp_options <- reactive({
                   x <- rbind(preconstro1_serv$carbsavenotimp, preconstro2_serv$carbsavenotimp, preconstro3_serv$carbsavenotimp, preconstro4_serv$carbsavenotimp, preconstro5_serv$carbsavenotimp,
                              embcarbonro1_serv$carbsavenotimp, embcarbonro2_serv$carbsavenotimp, embcarbonro3_serv$carbsavenotimp, embcarbonro4_serv$carbsavenotimp, embcarbonro5_serv$carbsavenotimp,
                              constro1_serv$carbsavenotimp, constro2_serv$carbsavenotimp, constro3_serv$carbsavenotimp, constro4_serv$carbsavenotimp, constro5_serv$carbsavenotimp,
                              usero1_serv$carbsavenotimp, usero2_serv$carbsavenotimp, usero3_serv$carbsavenotimp, usero4_serv$carbsavenotimp, usero5_serv$carbsavenotimp,
                              maintro1_serv$carbsavenotimp, maintro2_serv$carbsavenotimp, maintro3_serv$carbsavenotimp, maintro4_serv$carbsavenotimp, maintro5_serv$carbsavenotimp,
                              useremisro1_serv$carbsavenotimp, useremisro2_serv$carbsavenotimp, useremisro3_serv$carbsavenotimp, useremisro4_serv$carbsavenotimp, useremisro5_serv$carbsavenotimp,
                              eolifero1_serv$carbsavenotimp, eolifero2_serv$carbsavenotimp, eolifero3_serv$carbsavenotimp, eolifero4_serv$carbsavenotimp, eolifero5_serv$carbsavenotimp,
                              fill = T) %>%
                     filter(Description != "")
                   return(x)
                 })
                 
                 cat(file=stderr(), paste0(Sys.time()," *** road_carbsavenotimp_options:",session$token, "**** \n"))
                 
                 
                 # main summary data reactive
                 road_summary_data_react <- reactive({
                   
                   x <- rbindlist(list(preconstro1_serv$data, embcarbonro1_serv$data, constro1_serv$data, usero1_serv$data, useremisro1_serv$data, maintro1_serv$data, eolifero1_serv$data,
                                       preconstro2_serv$data, embcarbonro2_serv$data, constro2_serv$data, usero2_serv$data, useremisro2_serv$data, maintro2_serv$data, eolifero2_serv$data,
                                       preconstro3_serv$data, embcarbonro3_serv$data, constro3_serv$data, usero3_serv$data, useremisro3_serv$data, maintro3_serv$data, eolifero3_serv$data,
                                       preconstro4_serv$data, embcarbonro4_serv$data, constro4_serv$data, usero4_serv$data, useremisro4_serv$data, maintro4_serv$data, eolifero4_serv$data,
                                       preconstro5_serv$data, embcarbonro5_serv$data, constro5_serv$data, usero5_serv$data, useremisro5_serv$data, maintro5_serv$data, eolifero5_serv$data,
                                       preconstro6_serv$data, embcarbonro6_serv$data, constro6_serv$data, usero6_serv$data, useremisro6_serv$data, maintro6_serv$data, eolifero6_serv$data,
                                       preconstro7_serv$data, embcarbonro7_serv$data, constro7_serv$data, usero7_serv$data, useremisro7_serv$data, maintro7_serv$data, eolifero7_serv$data,
                                       preconstro8_serv$data, embcarbonro8_serv$data, constro8_serv$data, usero8_serv$data, useremisro8_serv$data, maintro8_serv$data, eolifero8_serv$data#,
                                       #preconstro9_serv$data, embcarbonro9_serv$data, constro9_serv$data, usero9_serv$data, useremisro9_serv$data, maintro9_serv$data, eolifero9_serv$data,
                                       #preconstro10_serv$data, embcarbonro10_serv$data, constro10_serv$data, usero10_serv$data, useremisro10_serv$data, maintro10_serv$data, eolifero10_serv$data
                                       ))
                   return(x)
                   
                 })
                 
                 
                 cat(file=stderr(), paste0(Sys.time()," *** road_summary_data_react:",session$token, "**** \n"))

                 # summary submodule
                 roadsummary_server("RoadSummary", "Road Summary & Dashboard", road_summary_data_react, road_embcarbon_details,
                                    road_carbsaveimp_options, road_carbsavenotimp_options, projectdetails_values, RoadHome_serv, 
                                    appR_returned)
                 
                 cat(file=stderr(), paste0(Sys.time()," *** roadsummary_server: ",session$token, "**** \n"))
                 
                 ###################################################
                 ##### RAIL SERVER #################################
                 ###################################################
                 
                 
                 RailHome_serv <- roadhome_server("RailHome", "Light Rail Home", appR_returned, projectdetails_values)
                 
                 cat(file=stderr(), paste0(Sys.time()," *** RailHome_serv: ",session$token, "**** \n"))
                 
                 baseline_server("baselinera1",1,"Baseline Light Rail Option 1","Baseline 1", appR_returned)
                 preconstra1_serv <- preconst_server("preconstra1",1,"Pre-Construction Light Rail Option 1","Pre-Construction 1", appR_returned) # return reactiveValues output data frame
                 embcarbonra1_serv <- embcarbon_server("embcarbonra1",1,"Embodied Carbon Light Rail Option 1","Embodied Carbon 1", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constra1_serv <- const_server("constra1",1,"Construction Light Rail Option 1","Construction 1", appR_returned)
                 usera1_serv <- use_server("usera1",1,"Operational Use Light Rail Option 1","Use 1", appR_returned, projectdetails_values)
                 useremisra1_serv <- useremisrail_server("useremisra1",1,"Rail User Emissions Option 1","User Emissions 1", appR_returned, projectdetails_values)
                 maintra1_serv <- maint_server("maintra1",1,"Maintenance Rail Option 1","Maintenance 1", appR_returned, projectdetails_values)
                 eolifera1_serv <- eolife_server("eolifera1",1,"End of Life Light Rail Option 1","End of Life 1", appR_returned)
                 
                 baseline_server("baselinera2",2,"Baseline Light Rail Option 2","Baseline 2", appR_returned)
                 preconstra2_serv <- preconst_server("preconstra2",2,"Pre-Construction Light Rail Option 2","Pre-Construction 2", appR_returned)
                 embcarbonra2_serv <- embcarbon_server("embcarbonra2",2,"Embodied Carbon Light Rail Option 2","Embodied Carbon 2", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constra2_serv <- const_server("constra2",2,"Construction Light Rail Option 2","Construction 2", appR_returned)
                 usera2_serv <- use_server("usera2",2,"Operational Use Light Rail Option 2","Use 2", appR_returned, projectdetails_values)
                 useremisra2_serv <- useremisrail_server("useremisra2",2,"Rail User Emissions Option 2","User Emissions 2", appR_returned, projectdetails_values)
                 maintra2_serv <- maint_server("maintra2",2,"Maintenance Rail Option 2","Maintenance 2", appR_returned, projectdetails_values)
                 eolifera2_serv <- eolife_server("eolifera2",2,"End of Life Light Rail Option 2","End of Life 2", appR_returned)
                 
                 baseline_server("baselinera3",3,"Baseline Light Rail Option 3","Baseline 3", appR_returned)
                 preconstra3_serv <- preconst_server("preconstra3",3,"Pre-Construction Light Rail Option 3","Pre-Construction 3", appR_returned)
                 embcarbonra3_serv <- embcarbon_server("embcarbonra3",3,"Embodied Carbon Light Rail Option 3","Embodied Carbon 3", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constra3_serv <- const_server("constra3",3,"Construction Light Rail Option 3","Construction 3", appR_returned)
                 usera3_serv <- use_server("usera3",3,"Operational Use Light Rail Option 3","Use 3", appR_returned, projectdetails_values)
                 useremisra3_serv <- useremisrail_server("useremisra3",3,"Rail User Emissions Option 3","User Emissions 3", appR_returned, projectdetails_values)
                 maintra3_serv <- maint_server("maintra3",3,"Maintenance Rail Option 3","Maintenance 3", appR_returned, projectdetails_values)
                 eolifera3_serv <- eolife_server("eolifera3",3,"End of Life Light Rail Option 3","End of Life 3", appR_returned)
                 
                 baseline_server("baselinera4",4,"Baseline Light Rail Option 4","Baseline 4", appR_returned)
                 preconstra4_serv <- preconst_server("preconstra4",4,"Pre-Construction Light Rail Option 4","Pre-Construction 4", appR_returned)
                 embcarbonra4_serv <- embcarbon_server("embcarbonra4",4,"Embodied Carbon Light Rail Option 4","Embodied Carbon 4", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constra4_serv <- const_server("constra4",4,"Construction Light Rail Option 4","Construction 4", appR_returned)
                 usera4_serv <- use_server("usera4",4,"Operational Use Light Rail Option 4","Use 4", appR_returned, projectdetails_values)
                 useremisra4_serv <- useremisrail_server("useremisra4",4,"Rail User Emissions Option 4","User Emissions 4", appR_returned, projectdetails_values)
                 maintra4_serv <- maint_server("maintra4",4,"Maintenance Rail Option 4","Maintenance 4", appR_returned, projectdetails_values)
                 eolifera4_serv <- eolife_server("eolifera4",4,"End of Life Light Rail Option 4","End of Life 4", appR_returned)
                 
                 baseline_server("baselinera5",5,"Baseline Light Rail Option 5","Baseline 5", appR_returned)
                 preconstra5_serv <- preconst_server("preconstra5",5,"Pre-Construction Light Rail Option 5","Pre-Construction 5", appR_returned)
                 embcarbonra5_serv <- embcarbon_server("embcarbonra5",5,"Embodied Carbon Light Rail Option 5","Embodied Carbon 5", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constra5_serv <- const_server("constra5",5,"Construction Light Rail Option 5","Construction 5", appR_returned)
                 usera5_serv <- use_server("usera5",5,"Operational Use Light Rail Option 5","Use 5", appR_returned, projectdetails_values)
                 useremisra5_serv <- useremisrail_server("useremisra5",5,"Rail User Emissions Option 5","User Emissions 5", appR_returned, projectdetails_values)
                 maintra5_serv <- maint_server("maintra5",5,"Maintenance Rail Option 5","Maintenance 5", appR_returned, projectdetails_values)
                 eolifera5_serv <- eolife_server("eolifera5",5,"End of Life Light Rail Option 5","End of Life 5", appR_returned)
                 
                 baseline_server("baselinera6",6,"Baseline Light Rail Option 6","Baseline 6", appR_returned)
                 preconstra6_serv <- preconst_server("preconstra6",6,"Pre-Construction Light Rail Option 6","Pre-Construction 6", appR_returned)
                 embcarbonra6_serv <- embcarbon_server("embcarbonra6",6,"Embodied Carbon Light Rail Option 6","Embodied Carbon 6", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constra6_serv <- const_server("constra6",6,"Construction Light Rail Option 6","Construction 6", appR_returned)
                 usera6_serv <- use_server("usera6",6,"Operational Use Light Rail Option 6","Use 6", appR_returned, projectdetails_values)
                 useremisra6_serv <- useremisrail_server("useremisra6",6,"Rail User Emissions Option 6","User Emissions 6", appR_returned, projectdetails_values)
                 maintra6_serv <- maint_server("maintra6",6,"Maintenance Rail Option 6","Maintenance 6", appR_returned, projectdetails_values)
                 eolifera6_serv <- eolife_server("eolifera6",6,"End of Life Light Rail Option 6","End of Life 6", appR_returned)
                 
                 baseline_server("baselinera7",7,"Baseline Light Rail Option 7","Baseline 7", appR_returned)
                 preconstra7_serv <- preconst_server("preconstra7",7,"Pre-Construction Light Rail Option 7","Pre-Construction 7", appR_returned)
                 embcarbonra7_serv <- embcarbon_server("embcarbonra7",7,"Embodied Carbon Light Rail Option 7","Embodied Carbon 7", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constra7_serv <- const_server("constra7",7,"Construction Light Rail Option 7","Construction 7", appR_returned)
                 usera7_serv <- use_server("usera7",7,"Operational Use Light Rail Option 7","Use 7", appR_returned, projectdetails_values)
                 useremisra7_serv <- useremisrail_server("useremisra7",7,"Rail User Emissions Option 7","User Emissions 7", appR_returned, projectdetails_values)
                 maintra7_serv <- maint_server("maintra7",7,"Maintenance Rail Option 7","Maintenance 7", appR_returned, projectdetails_values)
                 eolifera7_serv <- eolife_server("eolifera7",7,"End of Life Light Rail Option 7","End of Life 7", appR_returned)
                 
                 baseline_server("baselinera8",8,"Baseline Light Rail Option 8","Baseline 8", appR_returned)
                 preconstra8_serv <- preconst_server("preconstra8",8,"Pre-Construction Light Rail Option 8","Pre-Construction 8", appR_returned)
                 embcarbonra8_serv <- embcarbon_server("embcarbonra8",8,"Embodied Carbon Light Rail Option 8","Embodied Carbon 8", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 constra8_serv <- const_server("constra8",8,"Construction Light Rail Option 8","Construction 8", appR_returned)
                 usera8_serv <- use_server("usera8",8,"Operational Use Light Rail Option 8","Use 8", appR_returned, projectdetails_values)
                 useremisra8_serv <- useremisrail_server("useremisra8",8,"Rail User Emissions Option 8","User Emissions 8", appR_returned, projectdetails_values)
                 maintra8_serv <- maint_server("maintra8",8,"Maintenance Rail Option 8","Maintenance 8", appR_returned, projectdetails_values)
                 eolifera8_serv <- eolife_server("eolifera8",8,"End of Life Light Rail Option 8","End of Life 8", appR_returned)
                 
                 # baseline_server("baselinera9",9,"Baseline Light Rail Option 9","Baseline 9", appR_returned)
                 # preconstra9_serv <- preconst_server("preconstra9",9,"Pre-Construction Light Rail Option 9","Pre-Construction 9", appR_returned)
                 # embcarbonra9_serv <- embcarbon_server("embcarbonra9",9,"Embodied Carbon Light Rail Option 9","Embodied Carbon 9", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 # constra9_serv <- const_server("constra9",9,"Construction Light Rail Option 9","Construction 9", appR_returned)
                 # usera9_serv <- use_server("usera9",9,"Operational Use Light Rail Option 9","Use 9", appR_returned, projectdetails_values)
                 # useremisra9_serv <- useremisrail_server("useremisra9",9,"Rail User Emissions Option 9","User Emissions 9", appR_returned, projectdetails_values)
                 # maintra9_serv <- maint_server("maintra9",9,"Maintenance Rail Option 9","Maintenance 9", appR_returned, projectdetails_values)
                 # eolifera9_serv <- eolife_server("eolifera9",9,"End of Life Light Rail Option 9","End of Life 9", appR_returned)
                 # 
                 # baseline_server("baselinera10",10,"Baseline Light Rail Option 10","Baseline 10", appR_returned)
                 # preconstra10_serv <- preconst_server("preconstra10",10,"Pre-Construction Light Rail Option 10","Pre-Construction 10", appR_returned)
                 # embcarbonra10_serv <- embcarbon_server("embcarbonra10",10,"Embodied Carbon Light Rail Option 10","Embodied Carbon 10", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput)
                 # constra10_serv <- const_server("constra10",10,"Construction Light Rail Option 10","Construction 10", appR_returned)
                 # usera10_serv <- use_server("usera10",10,"Operational Use Light Rail Option 10","Use 10", appR_returned, projectdetails_values)
                 # useremisra10_serv <- useremisrail_server("useremisra10",10,"Rail User Emissions Option 10","User Emissions 10", appR_returned, projectdetails_values)
                 # maintra10_serv <- maint_server("maintra10",10,"Maintenance Rail Option 10","Maintenance 10", appR_returned, projectdetails_values)
                 # eolifera10_serv <- eolife_server("eolifera10",10,"End of Life Light Rail Option 10","End of Life 10", appR_returned)
                  
                 cat(file=stderr(), paste0(Sys.time()," *** RailHome_serv:options:",session$token, "**** \n"))
                 
                 ##### REACTIVE EXPRESSIONS TO PASS TO RAIL SUMMARY MODULE #####
                 
                 # detailed embodied carbon reactive to send to roadsummary
                 rail_embcarbon_details <- reactive({
                   
                   x <- rbind(embcarbonra1_serv$details, embcarbonra2_serv$details, embcarbonra3_serv$details, embcarbonra4_serv$details, embcarbonra5_serv$details,
                              embcarbonra6_serv$details, embcarbonra7_serv$details, embcarbonra8_serv$details#, embcarbonra9_serv$details, embcarbonra10_serv$details
                              )
                   return(x)
                   
                 })
                 
                 
                 rail_carbsaveimp_options <- reactive({
                   x <- rbind(preconstra1_serv$carbsaveimp, preconstra2_serv$carbsaveimp, preconstra3_serv$carbsaveimp, preconstra4_serv$carbsaveimp, preconstra5_serv$carbsaveimp,
                              embcarbonra1_serv$carbsaveimp, embcarbonra2_serv$carbsaveimp, embcarbonra3_serv$carbsaveimp, embcarbonra4_serv$carbsaveimp, embcarbonra5_serv$carbsaveimp,
                              constra1_serv$carbsaveimp, constra2_serv$carbsaveimp, constra3_serv$carbsaveimp, constra4_serv$carbsaveimp, constra5_serv$carbsaveimp,
                              usera1_serv$carbsaveimp, usera2_serv$carbsaveimp, usera3_serv$carbsaveimp, usera4_serv$carbsaveimp, usera5_serv$carbsaveimp,
                              maintra1_serv$carbsaveimp, maintra2_serv$carbsaveimp, maintra3_serv$carbsaveimp, maintra4_serv$carbsaveimp, maintra5_serv$carbsaveimp,
                              useremisra1_serv$carbsaveimp, useremisra2_serv$carbsaveimp, useremisra3_serv$carbsaveimp, useremisra4_serv$carbsaveimp, useremisra5_serv$carbsaveimp,
                              eolifera1_serv$carbsaveimp, eolifera2_serv$carbsaveimp, eolifera3_serv$carbsaveimp, eolifera4_serv$carbsaveimp, eolifera5_serv$carbsaveimp,
                              fill = T) %>%
                     filter(Description != "")
                   return(x)
                 })
                 
                 rail_carbsavenotimp_options <- reactive({
                   x <- rbind(preconstra1_serv$carbsavenotimp, preconstra2_serv$carbsavenotimp, preconstra3_serv$carbsavenotimp, preconstra4_serv$carbsavenotimp, preconstra5_serv$carbsavenotimp,
                              embcarbonra1_serv$carbsavenotimp, embcarbonra2_serv$carbsavenotimp, embcarbonra3_serv$carbsavenotimp, embcarbonra4_serv$carbsavenotimp, embcarbonra5_serv$carbsavenotimp,
                              constra1_serv$carbsavenotimp, constra2_serv$carbsavenotimp, constra3_serv$carbsavenotimp, constra4_serv$carbsavenotimp, constra5_serv$carbsavenotimp,
                              usera1_serv$carbsavenotimp, usera2_serv$carbsavenotimp, usera3_serv$carbsavenotimp, usera4_serv$carbsavenotimp, usera5_serv$carbsavenotimp,
                              maintra1_serv$carbsavenotimp, maintra2_serv$carbsavenotimp, maintra3_serv$carbsavenotimp, maintra4_serv$carbsavenotimp, maintra5_serv$carbsavenotimp,
                              useremisra1_serv$carbsavenotimp, useremisra2_serv$carbsavenotimp, useremisra3_serv$carbsavenotimp, useremisra4_serv$carbsavenotimp, useremisra5_serv$carbsavenotimp,
                              eolifera1_serv$carbsavenotimp, eolifera2_serv$carbsavenotimp, eolifera3_serv$carbsavenotimp, eolifera4_serv$carbsavenotimp, eolifera5_serv$carbsavenotimp,
                              fill = T) %>%
                     filter(Description != "")
                   return(x)
                 })
                 
                 
                 # main summary data reactive
                 rail_summary_data_react <- reactive({
                   
                   x <- rbindlist(list(preconstra1_serv$data, embcarbonra1_serv$data, constra1_serv$data, usera1_serv$data, useremisra1_serv$data, maintra1_serv$data, eolifera1_serv$data,
                                       preconstra2_serv$data, embcarbonra2_serv$data, constra2_serv$data, usera2_serv$data, useremisra2_serv$data, maintra2_serv$data, eolifera2_serv$data,
                                       preconstra3_serv$data, embcarbonra3_serv$data, constra3_serv$data, usera3_serv$data, useremisra3_serv$data, maintra3_serv$data, eolifera3_serv$data,
                                       preconstra4_serv$data, embcarbonra4_serv$data, constra4_serv$data, usera4_serv$data, useremisra4_serv$data, maintra4_serv$data, eolifera4_serv$data,
                                       preconstra5_serv$data, embcarbonra5_serv$data, constra5_serv$data, usera5_serv$data, useremisra5_serv$data, maintra5_serv$data, eolifera5_serv$data,
                                       preconstra6_serv$data, embcarbonra6_serv$data, constra6_serv$data, usera6_serv$data, useremisra6_serv$data, maintra6_serv$data, eolifera6_serv$data,
                                       preconstra7_serv$data, embcarbonra7_serv$data, constra7_serv$data, usera7_serv$data, useremisra7_serv$data, maintra7_serv$data, eolifera7_serv$data,
                                       preconstra8_serv$data, embcarbonra8_serv$data, constra8_serv$data, usera8_serv$data, useremisra8_serv$data, maintra8_serv$data, eolifera8_serv$data#,
                                       #preconstra9_serv$data, embcarbonra9_serv$data, constra9_serv$data, usera9_serv$data, useremisra9_serv$data, maintra9_serv$data, eolifera9_serv$data,
                                       #preconstra10_serv$data, embcarbonra10_serv$data, constra10_serv$data, usera10_serv$data, useremisra10_serv$data, maintra10_serv$data, eolifera10_serv$data
                                       ))
                   return(x)
                   
                 })
                 
                 
                 roadsummary_server("RailSummary", "Light Rail Summary & Dashboard", rail_summary_data_react, rail_embcarbon_details, 
                                    rail_carbsaveimp_options, rail_carbsavenotimp_options, projectdetails_values, RailHome_serv, appR_returned)
                 
                 ###################################################
                 ##### GREENWAY SERVER #############################
                 ###################################################
                 
                 
                 GreenwayHome_serv <- roadhome_server("GreenwayHome", "Greenway Home", appR_returned, projectdetails_values)
                 
                 cat(file=stderr(), paste0(Sys.time()," *** GreenwayHome_serv:",session$token, "**** \n"))
                 
                 baseline_server("baselinegw1",1,"Baseline Greenway Option 1","Baseline 1", appR_returned)
                 preconstgw1_serv <- preconst_server("preconstgw1",1,"Pre-Construction Greenway Option 1","Pre-Construction 1", appR_returned) # return reactiveValues output data frame
                 embcarbongw1_serv <- embcarbon_server("embcarbongw1",1,"Embodied Carbon Greenway Option 1","Embodied Carbon 1", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw1_serv <- const_server("constgw1",1,"Construction Greenway Option 1","Construction 1", appR_returned)
                 usegw1_serv <- use_server("usegw1",1,"Operational Use Greenway Option 1","Use 1", appR_returned, projectdetails_values)
                 useremisgw1_serv <- useremisgreenway_server("useremisgw1",1,"Greenway User Emissions Option 1","User Emissions 1", appR_returned, projectdetails_values)
                 maintgw1_serv <- maint_server("maintgw1",1,"Maintenance Greenway Option 1","Maintenance 1", appR_returned, projectdetails_values)
                 eolifegw1_serv <- eolife_server("eolifegw1",1,"End of Life Greenway Option 1","End of Life 1", appR_returned)
                 
                 baseline_server("baselinegw2",2,"Baseline Greenway Option 2","Baseline 2", appR_returned)
                 preconstgw2_serv <- preconst_server("preconstgw2",2,"Pre-Construction Greenway Option 2","Pre-Construction 2", appR_returned) # return reactiveValues output data frame
                 embcarbongw2_serv <- embcarbon_server("embcarbongw2",2,"Embodied Carbon Greenway Option 2","Embodied Carbon 2", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw2_serv <- const_server("constgw2",2,"Construction Greenway Option 2","Construction 2", appR_returned)
                 usegw2_serv <- use_server("usegw2",2,"Operational Use Greenway Option 2","Use 2", appR_returned, projectdetails_values)
                 useremisgw2_serv <- useremisgreenway_server("useremisgw2",2,"Greenway User Emissions Option 2","User Emissions 2", appR_returned, projectdetails_values)
                 maintgw2_serv <- maint_server("maintgw2",2,"Maintenance Greenway Option 2","Maintenance 2", appR_returned, projectdetails_values)
                 eolifegw2_serv <- eolife_server("eolifegw2",2,"End of Life Greenway Option 2","End of Life 2", appR_returned)
                 
                 baseline_server("baselinegw3",3,"Baseline Greenway Option 3","Baseline 3", appR_returned)
                 preconstgw3_serv <- preconst_server("preconstgw3",3,"Pre-Construction Greenway Option 3","Pre-Construction 3", appR_returned) # return reactiveValues output data frame
                 embcarbongw3_serv <- embcarbon_server("embcarbongw3",3,"Embodied Carbon Greenway Option 3","Embodied Carbon 3", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw3_serv <- const_server("constgw3",3,"Construction Greenway Option 3","Construction 3", appR_returned)
                 usegw3_serv <- use_server("usegw3",3,"Operational Use Greenway Option 3","Use 3", appR_returned, projectdetails_values)
                 useremisgw3_serv <- useremisgreenway_server("useremisgw3",3,"Greenway User Emissions Option 3","User Emissions 3", appR_returned, projectdetails_values)
                 maintgw3_serv <- maint_server("maintgw3",3,"Maintenance Greenway Option 3","Maintenance 3", appR_returned, projectdetails_values)
                 eolifegw3_serv <- eolife_server("eolifegw3",3,"End of Life Greenway Option 3","End of Life 3", appR_returned)
                 
                 baseline_server("baselinegw4",4,"Baseline Greenway Option 4","Baseline 4", appR_returned)
                 preconstgw4_serv <- preconst_server("preconstgw4",4,"Pre-Construction Greenway Option 4","Pre-Construction 4", appR_returned) # return reactiveValues output data frame
                 embcarbongw4_serv <- embcarbon_server("embcarbongw4",4,"Embodied Carbon Greenway Option 4","Embodied Carbon 4", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw4_serv <- const_server("constgw4",4,"Construction Greenway Option 4","Construction 4", appR_returned)
                 usegw4_serv <- use_server("usegw4",4,"Operational Use Greenway Option 4","Use 4", appR_returned, projectdetails_values)
                 useremisgw4_serv <- useremisgreenway_server("useremisgw4",4,"Greenway User Emissions Option 4","User Emissions 4", appR_returned, projectdetails_values)
                 maintgw4_serv <- maint_server("maintgw4",4,"Maintenance Greenway Option 4","Maintenance 4", appR_returned, projectdetails_values)
                 eolifegw4_serv <- eolife_server("eolifegw4",4,"End of Life Greenway Option 4","End of Life 4", appR_returned)
                 
                 baseline_server("baselinegw5",5,"Baseline Greenway Option 5","Baseline 5", appR_returned)
                 preconstgw5_serv <- preconst_server("preconstgw5",5,"Pre-Construction Greenway Option 5","Pre-Construction 5", appR_returned) # return reactiveValues output data frame
                 embcarbongw5_serv <- embcarbon_server("embcarbongw5",5,"Embodied Carbon Greenway Option 5","Embodied Carbon 5", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw5_serv <- const_server("constgw5",5,"Construction Greenway Option 5","Construction 5", appR_returned)
                 usegw5_serv <- use_server("usegw5",5,"Operational Use Greenway Option 5","Use 5", appR_returned, projectdetails_values)
                 useremisgw5_serv <- useremisgreenway_server("useremisgw5",5,"Greenway User Emissions Option 5","User Emissions 5", appR_returned, projectdetails_values)
                 maintgw5_serv <- maint_server("maintgw5",5,"Maintenance Greenway Option 5","Maintenance 5", appR_returned, projectdetails_values)
                 eolifegw5_serv <- eolife_server("eolifegw5",5,"End of Life Greenway Option 5","End of Life 5", appR_returned)
                 
                 baseline_server("baselinegw6",6,"Baseline Greenway Option 6","Baseline 6", appR_returned)
                 preconstgw6_serv <- preconst_server("preconstgw6",6,"Pre-Construction Greenway Option 6","Pre-Construction 6", appR_returned) # return reactiveValues output data frame
                 embcarbongw6_serv <- embcarbon_server("embcarbongw6",6,"Embodied Carbon Greenway Option 6","Embodied Carbon 6", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw6_serv <- const_server("constgw6",6,"Construction Greenway Option 6","Construction 6", appR_returned)
                 usegw6_serv <- use_server("usegw6",6,"Operational Use Greenway Option 6","Use 6", appR_returned, projectdetails_values)
                 useremisgw6_serv <- useremisgreenway_server("useremisgw6",6,"Greenway User Emissions Option 6","User Emissions 6", appR_returned, projectdetails_values)
                 maintgw6_serv <- maint_server("maintgw6",6,"Maintenance Greenway Option 6","Maintenance 6", appR_returned, projectdetails_values)
                 eolifegw6_serv <- eolife_server("eolifegw6",6,"End of Life Greenway Option 6","End of Life 6", appR_returned)
                 
                 baseline_server("baselinegw7",7,"Baseline Greenway Option 7","Baseline 7", appR_returned)
                 preconstgw7_serv <- preconst_server("preconstgw7",7,"Pre-Construction Greenway Option 7","Pre-Construction 7", appR_returned) # return reactiveValues output data frame
                 embcarbongw7_serv <- embcarbon_server("embcarbongw7",7,"Embodied Carbon Greenway Option 7","Embodied Carbon 7", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw7_serv <- const_server("constgw7",7,"Construction Greenway Option 7","Construction 7", appR_returned)
                 usegw7_serv <- use_server("usegw7",7,"Operational Use Greenway Option 7","Use 7", appR_returned, projectdetails_values)
                 useremisgw7_serv <- useremisgreenway_server("useremisgw7",7,"Greenway User Emissions Option 7","User Emissions 7", appR_returned, projectdetails_values)
                 maintgw7_serv <- maint_server("maintgw7",7,"Maintenance Greenway Option 7","Maintenance 7", appR_returned, projectdetails_values)
                 eolifegw7_serv <- eolife_server("eolifegw7",7,"End of Life Greenway Option 7","End of Life 7", appR_returned)
                 
                 baseline_server("baselinegw8",8,"Baseline Greenway Option 8","Baseline 8", appR_returned)
                 preconstgw8_serv <- preconst_server("preconstgw8",8,"Pre-Construction Greenway Option 8","Pre-Construction 8", appR_returned) # return reactiveValues output data frame
                 embcarbongw8_serv <- embcarbon_server("embcarbongw8",8,"Embodied Carbon Greenway Option 8","Embodied Carbon 8", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 constgw8_serv <- const_server("constgw8",8,"Construction Greenway Option 8","Construction 8", appR_returned)
                 usegw8_serv <- use_server("usegw8",8,"Operational Use Greenway Option 8","Use 8", appR_returned, projectdetails_values)
                 useremisgw8_serv <- useremisgreenway_server("useremisgw8",8,"Greenway User Emissions Option 8","User Emissions 8", appR_returned, projectdetails_values)
                 maintgw8_serv <- maint_server("maintgw8",8,"Maintenance Greenway Option 8","Maintenance 8", appR_returned, projectdetails_values)
                 eolifegw8_serv <- eolife_server("eolifegw8",8,"End of Life Greenway Option 8","End of Life 8", appR_returned)
                 
                 # baseline_server("baselinegw9",9,"Baseline Greenway Option 9","Baseline 9", appR_returned)
                 # preconstgw9_serv <- preconst_server("preconstgw9",9,"Pre-Construction Greenway Option 9","Pre-Construction 9", appR_returned) # return reactiveValues output data frame
                 # embcarbongw9_serv <- embcarbon_server("embcarbongw9",9,"Embodied Carbon Greenway Option 9","Embodied Carbon 9", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 # constgw9_serv <- const_server("constgw9",9,"Construction Greenway Option 9","Construction 9", appR_returned)
                 # usegw9_serv <- use_server("usegw9",9,"Operational Use Greenway Option 9","Use 9", appR_returned, projectdetails_values)
                 # useremisgw9_serv <- useremisgreenway_server("useremisgw9",9,"Greenway User Emissions Option 9","User Emissions 9", appR_returned, projectdetails_values)
                 # maintgw9_serv <- maint_server("maintgw9",9,"Maintenance Greenway Option 9","Maintenance 9", appR_returned, projectdetails_values)
                 # eolifegw9_serv <- eolife_server("eolifegw9",9,"End of Life Greenway Option 9","End of Life 9", appR_returned)
                 # 
                 # baseline_server("baselinegw10",10,"Baseline Greenway Option 10","Baseline 10", appR_returned)
                 # preconstgw10_serv <- preconst_server("preconstgw10",10,"Pre-Construction Greenway Option 10","Pre-Construction 10", appR_returned) # return reactiveValues output data frame
                 # embcarbongw10_serv <- embcarbon_server("embcarbongw10",10,"Embodied Carbon Greenway Option 10","Embodied Carbon 10", appR_returned, projectdetails_values, efs_react, efs_materialroad_userinput, efs_materialrail_userinput) # return reactiveValues output data frame
                 # constgw10_serv <- const_server("constgw10",10,"Construction Greenway Option 10","Construction 10", appR_returned)
                 # usegw10_serv <- use_server("usegw10",10,"Operational Use Greenway Option 10","Use 10", appR_returned, projectdetails_values)
                 # useremisgw10_serv <- useremisgreenway_server("useremisgw10",10,"Greenway User Emissions Option 10","User Emissions 10", appR_returned, projectdetails_values)
                 # maintgw10_serv <- maint_server("maintgw10",10,"Maintenance Greenway Option 10","Maintenance 10", appR_returned, projectdetails_values)
                 # eolifegw10_serv <- eolife_server("eolifegw10",10,"End of Life Greenway Option 10","End of Life 10", appR_returned)
				 
				 cat(file=stderr(), paste0(Sys.time()," *** GreenwayHome_serv:options:",session$token, "**** \n"))  

                 ##### REACTIVE EXPRESSIONS TO PASS TO GREENWAY SUMMARY MODULE #####
                 
                 # detailed embodied carbon reactive to send to roadsummary
                 greenway_embcarbon_details <- reactive({
                   
                   x <- rbind(embcarbongw1_serv$details, embcarbongw2_serv$details, embcarbongw3_serv$details, embcarbongw4_serv$details, embcarbongw5_serv$details,
                              embcarbongw6_serv$details, embcarbongw7_serv$details, embcarbongw8_serv$details#, embcarbongw9_serv$details, embcarbongw10_serv$details
                   )
                   return(x)
                   
                 })
                 
                 
                 greenway_carbsaveimp_options <- reactive({
                   x <- rbind(preconstgw1_serv$carbsaveimp, preconstgw2_serv$carbsaveimp, preconstgw3_serv$carbsaveimp, preconstgw4_serv$carbsaveimp, preconstgw5_serv$carbsaveimp,
                              embcarbongw1_serv$carbsaveimp, embcarbongw2_serv$carbsaveimp, embcarbongw3_serv$carbsaveimp, embcarbongw4_serv$carbsaveimp, embcarbongw5_serv$carbsaveimp,
                              constgw1_serv$carbsaveimp, constgw2_serv$carbsaveimp, constgw3_serv$carbsaveimp, constgw4_serv$carbsaveimp, constgw5_serv$carbsaveimp,
                              usegw1_serv$carbsaveimp, usegw2_serv$carbsaveimp, usegw3_serv$carbsaveimp, usegw4_serv$carbsaveimp, usegw5_serv$carbsaveimp,
                              maintgw1_serv$carbsaveimp, maintgw2_serv$carbsaveimp, maintgw3_serv$carbsaveimp, maintgw4_serv$carbsaveimp, maintgw5_serv$carbsaveimp,
                              useremisgw1_serv$carbsaveimp, useremisgw2_serv$carbsaveimp, useremisgw3_serv$carbsaveimp, useremisgw4_serv$carbsaveimp, useremisgw5_serv$carbsaveimp,
                              eolifegw1_serv$carbsaveimp, eolifegw2_serv$carbsaveimp, eolifegw3_serv$carbsaveimp, eolifegw4_serv$carbsaveimp, eolifegw5_serv$carbsaveimp,
                              fill = T) %>%
                     filter(Description != "")
                   return(x)
                 })
                 
                 greenway_carbsavenotimp_options <- reactive({
                   x <- rbind(preconstgw1_serv$carbsavenotimp, preconstgw2_serv$carbsavenotimp, preconstgw3_serv$carbsavenotimp, preconstgw4_serv$carbsavenotimp, preconstgw5_serv$carbsavenotimp,
                              embcarbongw1_serv$carbsavenotimp, embcarbongw2_serv$carbsavenotimp, embcarbongw3_serv$carbsavenotimp, embcarbongw4_serv$carbsavenotimp, embcarbongw5_serv$carbsavenotimp,
                              constgw1_serv$carbsavenotimp, constgw2_serv$carbsavenotimp, constgw3_serv$carbsavenotimp, constgw4_serv$carbsavenotimp, constgw5_serv$carbsavenotimp,
                              usegw1_serv$carbsavenotimp, usegw2_serv$carbsavenotimp, usegw3_serv$carbsavenotimp, usegw4_serv$carbsavenotimp, usegw5_serv$carbsavenotimp,
                              maintgw1_serv$carbsavenotimp, maintgw2_serv$carbsavenotimp, maintgw3_serv$carbsavenotimp, maintgw4_serv$carbsavenotimp, maintgw5_serv$carbsavenotimp,
                              useremisgw1_serv$carbsavenotimp, useremisgw2_serv$carbsavenotimp, useremisgw3_serv$carbsavenotimp, useremisgw4_serv$carbsavenotimp, useremisgw5_serv$carbsavenotimp,
                              eolifegw1_serv$carbsavenotimp, eolifegw2_serv$carbsavenotimp, eolifegw3_serv$carbsavenotimp, eolifegw4_serv$carbsavenotimp, eolifegw5_serv$carbsavenotimp,
                              fill = T) %>%
                     filter(Description != "")
                   return(x)
                 })
                 
                 
                 # main summary data reactive
                 greenway_summary_data_react <- reactive({
                   
                   x <- rbindlist(list(preconstgw1_serv$data, embcarbongw1_serv$data, constgw1_serv$data, usegw1_serv$data, useremisgw1_serv$data, maintgw1_serv$data, eolifegw1_serv$data,
                                       preconstgw2_serv$data, embcarbongw2_serv$data, constgw2_serv$data, usegw2_serv$data, useremisgw2_serv$data, maintgw2_serv$data, eolifegw2_serv$data,
                                       preconstgw3_serv$data, embcarbongw3_serv$data, constgw3_serv$data, usegw3_serv$data, useremisgw3_serv$data, maintgw3_serv$data, eolifegw3_serv$data,
                                       preconstgw4_serv$data, embcarbongw4_serv$data, constgw4_serv$data, usegw4_serv$data, useremisgw4_serv$data, maintgw4_serv$data, eolifegw4_serv$data,
                                       preconstgw5_serv$data, embcarbongw5_serv$data, constgw5_serv$data, usegw5_serv$data, useremisgw5_serv$data, maintgw5_serv$data, eolifegw5_serv$data,
                                       preconstgw6_serv$data, embcarbongw6_serv$data, constgw6_serv$data, usegw6_serv$data, useremisgw6_serv$data, maintgw6_serv$data, eolifegw6_serv$data,
                                       preconstgw7_serv$data, embcarbongw7_serv$data, constgw7_serv$data, usegw7_serv$data, useremisgw7_serv$data, maintgw7_serv$data, eolifegw7_serv$data,
                                       preconstgw8_serv$data, embcarbongw8_serv$data, constgw8_serv$data, usegw8_serv$data, useremisgw8_serv$data, maintgw8_serv$data, eolifegw8_serv$data#,
                                       #preconstgw9_serv$data, embcarbongw9_serv$data, constgw9_serv$data, usegw9_serv$data, useremisgw9_serv$data, maintgw9_serv$data, eolifegw9_serv$data,
                                       #preconstgw10_serv$data, embcarbongw10_serv$data, constgw10_serv$data, usegw10_serv$data, useremisgw10_serv$data, maintgw10_serv$data, eolifegw10_serv$data
                   ))
                   return(x)
                   
                 })
                 
                 roadsummary_server("GreenwaySummary", "Greenway Summary & Dashboard", greenway_summary_data_react, greenway_embcarbon_details,
                                    greenway_carbsaveimp_options, greenway_carbsavenotimp_options, projectdetails_values, GreenwayHome_serv, appR_returned)
                 
                 
                 ####################################
                 ##### EMISSION FACTORS #############
                 ####################################
                 
                 eflibrary_server("EFlibrary","Emission Factors", efs_react)
                 ccontrol_server("CControl","Change Control")
                 
                 #addcustomef_server("addcustomEFs","Add Custom Emission Factors")
                 
                 #################################################
                 ##### Resaved objs to take to app.R #############
                 #################################################
                 observe({
                   print("options.R line 376 --> Resaved objs to take to app.R")
                   #
                   
                   for (i in 1:nrow(collatedTableLoadFiles)){
                     #if (i == 535){browser()}
                     nameofServer <- get(collatedTableLoadFiles[i,3])
                     returned_Ops[[collatedTableLoadFiles[i,1]]] <- nameofServer[[collatedTableLoadFiles[i,4]]]
                   }
                 })
                 
                 
               }, session = getDefaultReactiveDomain()
               
      #cat(file=stderr(), paste0(Sys.time()," *** end options server:moduleServer",session$token, "**** \n"))
  )
  
  cat(file=stderr(), paste0(Sys.time()," *** options_server:moduleServer:", "**** \n"))
  
  return(returned_Ops)
  
}
