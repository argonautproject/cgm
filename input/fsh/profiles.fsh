Alias: $UCUM = http://unitsofmeasure.org
Alias: $LNC = http://loinc.org

ValueSet: GlucoseUnits
Id: glucose-units
Title: "Glucose Measurement Units"
Description: "Units for representing glucose measurements."
* $UCUM#mg/dL "mg/dL"
* $UCUM#mmol/L "mmol/L"

RuleSet: GlucoseMass
* value[x] only Quantity
  * ^short = "Glucose value as Quantity"
* valueQuantity
  * code = #mg/dL
  * unit = "mg/dl"
  * ^short = "Glucose value in mg/dL"

RuleSet: GlucoseMolar
* value[x] only Quantity
  * ^short = "Glucose value as Quantity"
* valueQuantity
  * code = #mmol/L
  * unit = "mmol/l"
  * ^short = "Glucose value in mmol/L"

Profile: CGMSensorReadingMass
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-sensor-reading-mass
Title: "CGM Sensor Reading (Mass)"
Description: "A continuous glucose monitoring (CGM) sensor reading represented in mass units."
* insert GlucoseMass
* code = $LNC#99504-3
  * ^short = "LOINC code for Glucose [Mass/volume] in Blood"
* effectiveDateTime 1..1 MS
  * ^short = "Time the measurement was taken"

Profile: CGMSensorReadingMolar
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-sensor-reading-molar
Title: "CGM Sensor Reading (Molar)"
Description: "A continuous glucose monitoring (CGM) sensor reading represented in molar units."
* insert GlucoseMolar
* code = $LNC#14745-4
  * ^short = "LOINC code for Glucose [Moles/volume] in Blood"
* effectiveDateTime 1..1 MS
  * ^short = "Time the measurement was taken"

RuleSet: CGMSummaryBase
* code
  * ^short = "Type of CGM summary observation"
* effectivePeriod 1..1 MS
  * ^short = "Reporting period for the CGM summary."
  * start 1..1 MS
    * ^short = "Start date of the reporting period (YYYY-MM-DD)"
  * end 1..1 MS
    * ^short = "End date of the reporting period (YYYY-MM-DD)"

Profile: CGMSummaryObservation
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary
Title: "CGM Summary Observation"
Description: "An observation representing a summary of continuous glucose monitoring (CGM) data."
* effectivePeriod 1..1 MS
  * ^short = "Reporting period for the CGM summary"
  * start 1..1 MS
    * ^short = "Start date of the reporting period (YYYY-MM-DD)"
  * end 1..1 MS
    * ^short = "End date of the reporting period (YYYY-MM-DD)"
* valueQuantity 1..1 MS
  * unit from GlucoseUnits (required)
    * ^short = "Unit of measure for the summary value"
  * system = $UCUM (exactly)
    * ^short = "Code system for units of measure"
  * ^short = "Summary value with appropriate glucose units"
* hasMember ^slicing.discriminator.type = #profile
  * ^short = "Slicing based on the profile of the referenced resource"
* hasMember ^slicing.discriminator.path = "resolve()"
  * ^short = "Path used to identify the slices"
* hasMember ^slicing.rules = #open
  * ^short = "Open slicing allowing additional slices"
* hasMember contains
    meanGlucoseMass 0..1 MS and
    meanGlucoseMolar 0..1 MS and
    timeInVeryLow 1..1 MS and
    timeInLow 1..1 MS and
    timeInTarget 1..1 MS and
    timeInHigh 1..1 MS and
    timeInVeryHigh 1..1 MS and
    gmi 1..1 MS and
    cv 1..1 MS and
    daysOfWear 1..1 MS and
    sensorActivePercentage 1..1 MS
  * ^short = "Slices representing different types of CGM summary observations"
* hasMember[meanGlucoseMass] only Reference(CGMSummaryMeanGlucoseMass)
  * ^short = "Reference to the Mean Glucose (Mass) observation"
* hasMember[meanGlucoseMolar] only Reference(CGMSummaryMeanGlucoseMolar)
  * ^short = "Reference to the Mean Glucose (Molar) observation"
* hasMember[timeInVeryLow] only Reference(CGMSummaryTimeInVeryLow)
  * ^short = "Reference to the Time in Very Low Range observation"
* hasMember[timeInLow] only Reference(CGMSummaryTimeInLow)
  * ^short = "Reference to the Time in Low Range observation"
* hasMember[timeInTarget] only Reference(CGMSummaryTimeInTarget)
  * ^short = "Reference to the Time in Target Range observation"
* hasMember[timeInHigh] only Reference(CGMSummaryTimeInHigh)
  * ^short = "Reference to the Time in High Range observation"
* hasMember[timeInVeryHigh] only Reference(CGMSummaryTimeInVeryHigh)
  * ^short = "Reference to the Time in Very High Range observation"
* hasMember[gmi] only Reference(CGMSummaryGMI)
  * ^short = "Reference to the Glucose Management Indicator (GMI) observation"
* hasMember[cv] only Reference(CGMSummaryCoefficientOfVariation)
  * ^short = "Reference to the Coefficient of Variation (CV) observation"
* hasMember[daysOfWear] only Reference(CGMSummaryDaysOfWear)
  * ^short = "Reference to the Days of Wear observation"
* hasMember[sensorActivePercentage] only Reference(CGMSummarySensorActivePercentage)
  * ^short = "Reference to the Sensor Active Percentage observation"

Profile: CGMSummaryPDF
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab
Id: cgm-summary-pdf
Title: "CGM Summary PDF Report"
Description: "A PDF report containing a summary of continuous glucose monitoring (CGM) data."
* code = CGMSummaryCodesTemporary#cgm-summary
  * ^short = "Code for CGM Summary report"
* effectivePeriod 1..1 MS
  * start 1..1 MS
    * ^short = "Start date of the reporting period (YYYY-MM-DD)"
  * end 1..1 MS
    * ^short = "End date of the reporting period (YYYY-MM-DD)"
* presentedForm 1..1 MS
  * ^short = "The PDF report content"
* presentedForm.contentType 1..1 MS
  * ^short = "Content type of the report (application/pdf)"
* presentedForm.data 1..1 MS
  * ^short = "Base64-encoded PDF report data"
* presentedForm.contentType = #application/pdf
  * ^short = "PDF content type"
* presentedForm.data 1..1 MS

Profile: CGMSummaryMeanGlucoseMass
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-mean-glucose-mass
Title: "Mean Glucose (Mass)"
Description: "The mean glucose value from a continuous glucose monitoring (CGM) summary, represented in mass units."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#mean-glucose
  * ^short = "Code for Mean Glucose observation"
* insert GlucoseMass

Profile: CGMSummaryMeanGlucoseMolar
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-mean-glucose-molar
Title: "Mean Glucose (Molar)"
Description: "The mean glucose value from a continuous glucose monitoring (CGM) summary, represented in molar units."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#mean-glucose
  * ^short = "Code for Mean Glucose observation"
* insert GlucoseMolar

RuleSet: QuantityPercent
* value[x] only Quantity
* valueQuantity 1..1
  * unit = "%" (exactly)
    * ^short = "Percentage unit"
  * code = #d (exactly)
    * ^short = "Dimensionless UCUM code"
  * system = $UCUM (exactly)
    * ^short = "UCUM code system"
  * ^short = "Value as a percentage"

Profile: CGMSummaryTimeInVeryLow
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-time-in-very-low
Title: "Time in Very Low Range"
Description: "The percentage of time glucose values were in the very low range during the reporting period."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#time-in-very-low
  * ^short = "Code for Time in Very Low Range observation"
* insert QuantityPercent

Profile: CGMSummaryTimeInLow
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-time-in-low
Title: "Time in Low Range"
Description: "The percentage of time glucose values were in the low range during the reporting period."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#time-in-low
  * ^short = "Code for Time in Low Range observation"
* insert QuantityPercent

Profile: CGMSummaryTimeInTarget
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-time-in-target
Title: "Time in Target Range"
Description: "The percentage of time glucose values were in the target range during the reporting period."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#time-in-target
  * ^short = "Code for Time in Target Range observation"
* insert QuantityPercent

Profile: CGMSummaryTimeInHigh
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-time-in-high
Title: "Time in High Range"
Description: "The percentage of time glucose values were in the high range during the reporting period."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#time-in-high
  * ^short = "Code for Time in High Range observation"
* insert QuantityPercent

Profile: CGMSummaryTimeInVeryHigh
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-time-in-very-high
Title: "Time in Very High Range"
Description: "The percentage of time glucose values were in the very high range during the reporting period."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#time-in-very-high
  * ^short = "Code for Time in Very High Range observation"
* insert QuantityPercent

Profile: CGMSummaryGMI
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-gmi
Title: "Glucose Management Indicator (GMI)"
Description: "The Glucose Management Indicator (GMI) value from a continuous glucose monitoring (CGM) summary."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#gmi
  * ^short = "Code for Glucose Management Indicator (GMI) observation"
* insert QuantityPercent

Profile: CGMSummaryCoefficientOfVariation
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-coefficient-of-variation
Title: "Coefficient of Variation (CV)"
Description: "The Coefficient of Variation (CV) value from a continuous glucose monitoring (CGM) summary."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#cv
  * ^short = "Code for Coefficient of Variation (CV) observation"
* insert QuantityPercent

Profile: CGMSummaryDaysOfWear
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-days-of-wear
Title: "Days of Wear"
Description: "The number of days the continuous glucose monitoring (CGM) device was worn during the reporting period."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#days-of-wear
  * ^short = "Code for Days of Wear observation"
* valueQuantity 1..1 MS
  * unit = "days" (exactly)
    * ^short = "Days unit"
  * code = #d
    * ^short = "UCUM code for days"
  * system = $UCUM (exactly)
    * ^short = "UCUM code system"
  * ^short = "Number of days the CGM device was worn"

Profile: CGMSummarySensorActivePercentage
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-sensor-active-percentage
Title: "Sensor Active Percentage"
Description: "The percentage of time the continuous glucose monitoring (CGM) sensor was active during the reporting period."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#sensor-active-percentage
  * ^short = "Code for Sensor Active Percentage observation"
* insert QuantityPercent

Profile: CGMDevice
Parent: Device
Id: cgm-device
Title: "CGM Device"
Description: "A continuous glucose monitoring (CGM) device."
* deviceName ^slicing.rules = #open
* deviceName ^slicing.discriminator.type = #value
* deviceName ^slicing.discriminator.path = "type"
* deviceName contains
    cgmDeviceName 1..* MS
* deviceName[cgmDeviceName].name 1..1 MS
  * ^short = "User-friendly name of the CGM device"
* deviceName[cgmDeviceName].type = #user-friendly-name
  * ^short = "Type indicating a user-friendlyname"
* serialNumber 1..1 MS
  * ^short = "Serial number of the CGM device"
* identifier 1..* MS
  * ^short = "Identifiers for the CGM device"

CodeSystem: CGMCodes
Id: cgm
Title: "Codes for CGM"
Description: "Codes to identify content associated with this IG"
* ^experimental = false
* #cgm-submission-bundle "CGM Bundle"
* #cgm-submission-order "CGM Submission Order"

CodeSystem: CGMSummaryCodesTemporary
Id: cgm-summary-codes-temporary
Title: "CGM Summary Code System"
Description: "Temporary code system for CGM summary observations."
* ^experimental = false
* #cgm-summary "CGM Summary"
* #mean-glucose "Mean Glucose"
* #time-in-very-low "Time in Very Low Range"
* #time-in-low "Time in Low Range"
* #time-in-target "Time in Target Range"
* #time-in-high "Time in High Range"
* #time-in-very-high "Time in Very High Range" 
* #gmi "Glucose Management Indicator (GMI)"
* #cv "Coefficient of Variation (CV)"
* #days-of-wear "Days of Wear"
* #sensor-active-percentage "Sensor Active Percentage"

// ValueSet: CGMSummary
// Id: cgm-summary
// Title: "CGM Summary Value Set"
// Description: "Value set for CGM summary observations."
// * include codes from system CGMSummary

Instance: CGMSummaryToLoinc
InstanceOf: ConceptMap
Usage: #definition
Title: "Mapping from CGM Summary to LOINC"
Description: "Mapping concepts from the CGM Summary code system to LOINC codes."
* status = #draft
* group[+].source = Canonical(CGMSummaryCodesTemporary)
* group[=].target = $LNC
* group[=].element[+].code = #mean-glucose
* group[=].element[=].target[+].code = #97507-8
* group[=].element[=].target[=].equivalence = #equivalent
* group[=].element[+].code = #time-in-target
* group[=].element[=].target[+].code = #97510-2
* group[=].element[=].target[=].equivalence = #equivalent
* group[=].element[+].code = #gmi 
* group[=].element[=].target[+].code = #97506-0
* group[=].element[=].target[=].equivalence = #equivalent

Profile: CGMDataSubmissionBundle
Parent: Bundle
Id: cgm-data-submission-bundle
Title: "CGM Data Submission Bundle"
Description: "A bundle for submitting continuous glucose monitoring (CGM) data, including devices, observations, summaries, and optionally patient information."
* type = #collection (exactly)
  * ^short = "Bundle type is collection"
* timestamp 1..1 MS
  * ^short = "Time the bundle was created"
* entry ^slicing.discriminator.type = #profile
  * ^short = "Slicing based on the profile of the resource"
* entry ^slicing.discriminator.path = "resource"
  * ^short = "Path to the resource element for slicing" 
* entry ^slicing.rules = #open
  * ^short = "Open slicing allowing additional slices"
* entry contains
    patient 0..1 MS and
    cgmDevice 0..* MS and
    cgmSensorReadingMolar 0..* MS and
    cgmSensorReadingMass 0..* MS and
    cgmSummary 0..* MS and
    cgmSummaryPDF 0..* MS and
    cgmSummaryMeanGlucoseMass 0..* MS and
    cgmSummaryMeanGlucoseMolar 0..* MS and
    cgmSummaryTimeInVeryLow 0..* MS and
    cgmSummaryTimeInLow 0..* MS and
    cgmSummaryTimeInTarget 0..* MS and
    cgmSummaryTimeInHigh 0..* MS and
    cgmSummaryTimeInVeryHigh 0..* MS and
    cgmSummaryGMI 0..* MS and
    cgmSummaryCoefficientOfVariation 0..* MS and
    cgmSummaryDaysOfWear 0..* MS and
    cgmSummarySensorActivePercentage 0..* MS
  * ^short = "Slices representing different resource types in the bundle"
* entry 1..* MS
  * ^short = "At least one entry is required"
* entry[patient].resource only us-core-patient
  * ^short = "Patient entry must conform to us-core-patient profile"
* entry[cgmSummary].resource only CGMSummaryObservation
  * ^short = "CGM summary entry must conform to CGMSummaryObservation profile"
* entry[cgmSummaryPDF].resource only CGMSummaryPDF
  * ^short = "CGM summary PDF entry must conform to CGMSummaryPDF profile" 
* entry[cgmDevice].resource only CGMDevice
  * ^short = "CGM device entry must conform to CGMDevice profile"
* entry[cgmSensorReadingMass].resource only CGMSensorReadingMass
  * ^short = "CGM sensor reading (mass) entry must conform to CGMSensorReadingMass profile"
* entry[cgmSensorReadingMolar].resource only CGMSensorReadingMolar
  * ^short = "CGM sensor reading (molar) entry must conform to CGMSensorReadingMolar profile"
* entry[cgmSummaryMeanGlucoseMass].resource only CGMSummaryMeanGlucoseMass
  * ^short = "Mean glucose (mass) entry must conform to CGMSummaryMeanGlucoseMass profile"
* entry[cgmSummaryMeanGlucoseMolar].resource only CGMSummaryMeanGlucoseMolar
  * ^short = "Mean glucose (molar) entry must conform to CGMSummaryMeanGlucoseMolar profile"
* entry[cgmSummaryTimeInVeryLow].resource only CGMSummaryTimeInVeryLow
  * ^short = "Time in very low entry must conform to CGMSummaryTimeInVeryLow profile"
* entry[cgmSummaryTimeInLow].resource only CGMSummaryTimeInLow
  * ^short = "Time in low entry must conform to CGMSummaryTimeInLow profile"
* entry[cgmSummaryTimeInTarget].resource only CGMSummaryTimeInTarget
  * ^short = "Time in target entry must conform to CGMSummaryTimeInTarget profile"
* entry[cgmSummaryTimeInHigh].resource only CGMSummaryTimeInHigh
  * ^short = "Time in high entry must conform to CGMSummaryTimeInHigh profile"
* entry[cgmSummaryTimeInVeryHigh].resource only CGMSummaryTimeInVeryHigh
  * ^short = "Time in very high entry must conform to CGMSummaryTimeInVeryHigh profile"
* entry[cgmSummaryGMI].resource only CGMSummaryGMI
  * ^short = "GMI entry must conform to CGMSummaryGMI profile"
* entry[cgmSummaryCoefficientOfVariation].resource only CGMSummaryCoefficientOfVariation  
  * ^short = "CV entry must conform to CGMSummaryCoefficientOfVariation profile"
* entry[cgmSummaryDaysOfWear].resource only CGMSummaryDaysOfWear
  * ^short = "Days of wear entry must conform to CGMSummaryDaysOfWear profile"
* entry[cgmSummarySensorActivePercentage].resource only CGMSummarySensorActivePercentage
  * ^short = "Sensor active percentage entry must conform to CGMSummarySensorActivePercentage profile"

Profile: CGMDataSubmissionStandingOrder
Parent: ServiceRequest
Id: cgm-data-submission-standing-order
Title: "Data Submission Standing Order"
Description: """**Sstanding order for data submission from an app to an EHR.**

This profile can be used by an EHR to communicate its preferences for data submission frequency and content. Data Submitterss can query for standing orders and use them to guide future submissions.

### Guiding Data Submission

This profiles represents a standing order for data submission, specifying the patient, the type of data to be submitted, the desired frequency of submission.

#### DataSubmissionSchedule

The `DataSubmissionSchedule` extension contains:

- `submissionFrequency` (1..1): A `Timing` element that specifies the frequency or schedule for data submission. It includes elements a `frequency`, `period`, `periodUnit`, and optionally `maxFrequencey` define the desired submission schedule.

- `submissionDataProfile` (1..*): A list of `canonical` references to FHIR profiles that represent the types of data to be submitted according to the specified schedule.

Multiple `DataSubmissionSchedule` extensions can be included in a single `DataSubmissionRequest` resource, allowing for different submission schedules and data profiles to be specified in the same request.

"""

* status MS
* intent MS
* code = CGMCodes#cgm-submission-order
  * ^short = "Code for CGM submission request"
* subject 1..1 MS
  * ^short = "Patient for the submission request"
* extension contains 
    DataSubmissionSchedule named dataSubmissionSchedule 0..*
  * ^short = "Schedules for data submission"

Extension: DataSubmissionSchedule
Id: data-submission-schedule
Title: "Data Submission Schedule"
Description: "Schedule and type of data to be submitted"

* extension contains
    submissionFrequency 1..1 MS and
    submissionDataProfile 1..*  MS
  * ^short = "Submission frequency and data profiles"
* extension[submissionFrequency].value[x] only Timing
  * ^short = "Timing for data submission"
* extension[submissionFrequency].valueTiming.repeat.frequency 1..1 MS
  * ^short = "Intended frequency of submission"
* extension[submissionFrequency].valueTiming.repeat.frequencyMax 0..1 MS
  * ^short = "Maximum frequency of submission"
* extension[submissionFrequency].valueTiming.repeat.period 1..1 MS
  * ^short = "Period for submission frequency" 
* extension[submissionFrequency].valueTiming.repeat.periodUnit 1..1 MS
  * ^short = "Unit for the period (typically d, wk, or mo)"
* extension[submissionDataProfile].value[x] only canonical
* extension[submissionDataProfile].valueCanonical 1..1 MS
  * ^short = "Data profile for submission"
