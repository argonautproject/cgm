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
* valueQuantity
  * code = #mg/dL
  * unit = "mg/dl"
  * ^short = "Glucose value in mg/dL"

RuleSet: GlucoseMolar
* value[x] only Quantity
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
* effectiveDateTime 1..1 MS
  * ^short = "Time the measurement was taken"

Profile: CGMSensorReadingMolar
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-sensor-reading-molar
Title: "CGM Sensor Reading (Molar)"
Description: "A continuous glucose monitoring (CGM) sensor reading represented in molar units."
* insert GlucoseMolar
* code = $LNC#14745-4
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
* hasMember ^slicing.discriminator.type = #pattern
  * ^short = "Slicing based on the profile of the referenced resource"
* hasMember ^slicing.discriminator.path = "resolve().code"
  * ^short = "Path used to identify the slices"
* hasMember ^slicing.rules = #open
  * ^short = "Open slicing allowing additional slices"  
* hasMember contains
    meanGlucoseMass 0..1 MS and
    meanGlucoseMolar 0..1 MS and
    timesInRanges 1..1 MS and 
    gmi 1..1 MS and
    cv 1..1 MS and
    daysOfWear 1..1 MS and
    sensorActivePercentage 1..1 MS
  * ^short = "CGM summary observations"
* hasMember[meanGlucoseMass] only Reference(CGMSummaryMeanGlucoseMass)
  * ^short = "Mean Glucose (Mass) observation"
* hasMember[meanGlucoseMolar] only Reference(CGMSummaryMeanGlucoseMolar)
  * ^short = "Mean Glucose (Molar) observation" 
* hasMember[timesInRanges] only Reference(CGMSummaryTimesInRanges)
  * ^short = "Times in Ranges observation"
* hasMember[gmi] only Reference(CGMSummaryGMI)
  * ^short = "Glucose Management Indicator (GMI) observation"
* hasMember[cv] only Reference(CGMSummaryCoefficientOfVariation)
  * ^short = "Coefficient of Variation (CV) observation"
* hasMember[daysOfWear] only Reference(CGMSummaryDaysOfWear)
  * ^short = "Days of Wear observation"
* hasMember[sensorActivePercentage] only Reference(CGMSummarySensorActivePercentage)
  * ^short = "Sensor Active Percentage observation"

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

Profile: CGMSummaryTimesInRanges
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-times-in-ranges
Title: "CGM Summary Times in Ranges"
Description: "An observation representing the times in various ranges from a continuous glucose monitoring (CGM) summary."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#times-in-ranges
  * ^short = "Code for Times in Ranges observation"
* component ^slicing.discriminator.type = #pattern
  * ^short = "Slicing based on the pattern of the component.code"
* component ^slicing.discriminator.path = "code"
  * ^short = "Path used to identify the slices"
* component ^slicing.rules = #open
  * ^short = "Open slicing allowing additional slices"
* component contains
    timeInVeryLow 1..1 MS and
    timeInLow 1..1 MS and 
    timeInTarget 1..1 MS and
    timeInHigh 1..1 MS and
    timeInVeryHigh 1..1 MS
  * ^short = "Components representing times in different ranges"
* component[timeInVeryLow]
  * code = CGMSummaryCodesTemporary#time-in-very-low
  * insert QuantityPercent
* component[timeInLow]  
  * code = CGMSummaryCodesTemporary#time-in-low
  * insert QuantityPercent
* component[timeInTarget]
  * code ^patternCodeableConcept.coding[0] = CGMSummaryCodesTemporary#time-in-target
  * code ^patternCodeableConcept.coding[1] = $LNC#97510-2
  * insert QuantityPercent
* component[timeInHigh]
  * code = CGMSummaryCodesTemporary#time-in-high    
  * insert QuantityPercent
* component[timeInVeryHigh]
  * code = CGMSummaryCodesTemporary#time-in-very-high
  * insert QuantityPercent
 
Profile: CGMSummaryMeanGlucoseMass
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-mean-glucose-mass
Title: "Mean Glucose (Mass)"
Description: "The mean glucose value from a continuous glucose monitoring (CGM) summary, represented in mass units."
* insert CGMSummaryBase
* code ^patternCodeableConcept.coding[0] = CGMSummaryCodesTemporary#mean-glucose-mass
* code ^patternCodeableConcept.coding[1] = $LNC#97507-8
  * ^short = "Code for Mean Glucose observation"
* insert GlucoseMass

Profile: CGMSummaryMeanGlucoseMolar
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-mean-glucose-molar
Title: "Mean Glucose (Molar)"
Description: "The mean glucose value from a continuous glucose monitoring (CGM) summary, represented in molar units."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#mean-glucose-molar
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

Profile: CGMSummaryGMI
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id: cgm-summary-gmi
Title: "Glucose Management Indicator (GMI)"
Description: "The Glucose Management Indicator (GMI) value from a continuous glucose monitoring (CGM) summary."
* insert CGMSummaryBase
* code = CGMSummaryCodesTemporary#gmi
  * ^short = "Code for Glucose Management Indicator (GMI) observation"
* code ^patternCodeableConcept.coding[1] = CGMSummaryCodesTemporary#gmi
* code ^patternCodeableConcept.coding[1] = $LNC#97506-0
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
* #cgm-data-submission-bundle "CGM Bundle"
* #cgm-data-submission-standing-order "CGM Submission Standing Order"

CodeSystem: CGMSummaryCodesTemporary
Id: cgm-summary-codes-temporary
Title: "CGM Summary Code System"
Description: "Temporary code system for CGM summary observations."
* ^experimental = false
* #cgm-summary "CGM Summary"
* #mean-glucose-mass "Mean Glucose (Mass per Volume)"
* #mean-glucose-molar "Mean Glucose (Moles per Volume)"
* #times-in-ranges "Time in Glucose Ranges"
* #time-in-very-low "Time in Very Low Range"
* #time-in-low "Time in Low Range"
* #time-in-target "Time in Target Range"
* #time-in-high "Time in High Range"
* #time-in-very-high "Time in Very High Range" 
* #gmi "Glucose Management Indicator (GMI)"
* #cv "Coefficient of Variation (CV)"
* #days-of-wear "Days of Wear"
* #sensor-active-percentage "Sensor Active Percentage"

Instance: CGMSummaryToLoinc
InstanceOf: ConceptMap
Usage: #definition
Title: "Mapping from CGM Summary to LOINC"
Description: "Mapping concepts from the CGM Summary code system to LOINC codes."
* status = #draft
* group[+].source = Canonical(CGMSummaryCodesTemporary)
* group[=].target = $LNC
* group[=].element[+]
  * code = #mean-glucose-mass
  * target[+].code = #97507-8
  * target[=].equivalence = #equivalent
* group[=].element[+]
  * code = #mean-glucose-molar
* group[=].element[+]
  * code = #time-in-very-low
* group[=].element[+]
  * code = #time-in-low
* group[=].element[+]
  * code = #time-in-target
  * target[+].code = #97510-2
  * target[=].equivalence = #equivalent
* group[=].element[+]
  * code = #time-in-high
* group[=].element[+]
  * code = #time-in-very-high
* group[=].element[+]
  * code = #gmi
  * target[+].code = #97506-0
  * target[=].equivalence = #equivalent
* group[=].element[+]
  * code = #cv
* group[=].element[+]
  * code = #days-of-wear
* group[=].element[+]
  * code = #sensor-active-percentage


Profile: CGMDataSubmissionBundle
Parent: Bundle
Id: cgm-data-submission-bundle
Title: "CGM Data Submission Bundle"
Description: """
Once a Data Submitter is connected to the EHR, it can write data by submitting a `batch` Bundle to the EHR FHIR sever's `/` submission endpoint.
The submission bundle includes a `Bundle.meta.tag` value of `cgm-data-submission-bundle` to support ingestion workflows on servers with limited data ingestion capabilities. The tag has no impact on the meaning of the bundle, and can safely be ignored by servers that offer a general-purpose `POST /` endpoint.

The Bundle `entry` array includes any combination of 

* CGM Summary PDF Reports ([Profile](StructureDefinition-cgm-summary-pdf.html#profile), [Example](DiagnosticReport-cgmSummaryPDFExample.json.html#root))
* CGM Summary Observation ([Profile](StructureDefinition-cgm-summary.html#profile), [Example](Observation-cgmSummary.json.html#root))
  * Mean Glucose ([Profile](StructureDefinition-cgm-summary-mean-glucose-mass.html#profile), [Example](Observation-cgmSummaryMeanGlucoseMassExample.json.html#root))
  * Times in Ranges ([Profile](StructureDefinition-cgm-summary-times-in-ranges.html#profile), [Example](Observation-cgmSummaryTimesInRangesExample.json.html#root))
  * Glucose Management Index ([Profile](StructureDefinition-cgm-summary-gmi.html#profile), [Example](Observation-cgmSummaryGMIExample.json.html#root))
  * Coefficient of Variations ([Profile](StructureDefinition-cgm-summary-coefficient-of-variation.html#profile), [Example](Observation-cgmSummaryCoefficientOfVariationExample.json.html#root))
  * Sensor Days of Wear ([Profile](StructureDefinition-cgm-summary-days-of-wear.html#profile), [Example](Observation-cgmSummaryDaysOfWearExample.json.html#root))
  * Sensor Active Percentage ([Profile](StructureDefinition-cgm-summary-sensor-active-percentage.html#profile), [Example](Observation-cgmSummarySensorActivePercentageExample.json.html#root))
* CGM Devices ([Profile](StructureDefinition-cgm-device.html#profile), [Example](Device-cgmDeviceExample.json.html#root))
* CGM Sensor Readings ([Profile](StructureDefinition-cgm-sensor-reading-mass.html#profile), [Example](Observation-cgmSensorReadingMassExample.json.html#root))
"""

* meta.tag
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* meta.tag contains
    cgmSubmissionBundle 1..1 MS
  * ^short = "Tag for CGM submission bundle"
* meta.tag[cgmSubmissionBundle] = CGMCodes#cgm-data-submission-bundle
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
    cgmSummaryTimesInRanges 0..* MS and
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
* entry[cgmSummaryTimesInRanges].resource only CGMSummaryTimesInRanges
  * ^short = "Times spent in ranges entry must conform to CGMSummaryTimesInRanges profile"
* entry[cgmSummaryGMI].resource only CGMSummaryGMI
  * ^short = "GMI entry must conform to CGMSummaryGMI profile"
* entry[cgmSummaryCoefficientOfVariation].resource only CGMSummaryCoefficientOfVariation  
  * ^short = "CV entry must conform to CGMSummaryCoefficientOfVariation profile"
* entry[cgmSummaryDaysOfWear].resource only CGMSummaryDaysOfWear
  * ^short = "Days of wear entry must conform to CGMSummaryDaysOfWear profile"
* entry[cgmSummarySensorActivePercentage].resource only CGMSummarySensorActivePercentage
  * ^short = "Sensor active percentage entry must conform to CGMSummarySensorActivePercentage profile"

Profile: CGMDataSubmissionStandingOrder
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-servicerequest
Id: cgm-data-submission-standing-order
Title: "Data Submission Standing Order"
Description: """
The Data Receiver can expose a standing order indicating:

* how often a Data Submitter should submit CGM data
* what data a Data Submitter should include in each CGM Data Submission Bundle.


**Guiding Data Submission**

This standing order is modeled as a FHIR `ServiceRequest` resource, which 
Data Submitters can query to guide their future submissions. The standing order specifyies the patient, the type of data to be submitted, and the desired frequency of submission.

**DataSubmissionSchedule**

The `DataSubmissionSchedule` extension contains:

- `submissionFrequency` (1..1): A `Timing` element that specifies the frequency or schedule for data submission. It includes elements a `frequency`, `period`, `periodUnit`, and optionally `maxFrequencey` define the desired submission schedule.

- `submissionDataProfile` (1..*): A list of `canonical` references to FHIR profiles that represent the types of data to be submitted according to the specified schedule.

Multiple `DataSubmissionSchedule` extensions can be included in a single `DataSubmissionRequest` resource if the Data Recipient prefers a different schedule for different data types.

It's important to note that submissions can also be **manually triggered by a patient or provider** within an app. For example, if there is an upcoming appointment, the provider can click a button to manually trigger submission of the most up-to-date results. Out-of-band communication between the app developer and the clinical provider system can also be used to establish preferred submission schedules.

"""
* intent = #order
* code = CGMCodes#cgm-data-submission-standing-order
  * ^short = "Code for CGM submission standing order"
* subject 1..1
  * ^short = "Patient for the submission order"
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
