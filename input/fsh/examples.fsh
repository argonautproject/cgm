Instance: patientExample
InstanceOf: http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient
Title: "Example Patient" 
Usage: #example
* identifier[0].use = #official
* identifier[0].system = "http://example.org"
* identifier[0].value = "ee8d4ac0-545c-4501-8d7e-646bfbda1db5"
* name.family = "Peters"
* name.given[0] = "Amy"
* gender = #female
* birthDate = "1964-06-20"

Instance: cgmSensorReadingMassExample
InstanceOf: CGMSensorReadingMass
Title: "CGM Sensor Reading (Mass) Example"
Usage: #example
* status = #final 
* code = $LNC#99504-3
* subject = Reference(PatientExample)
* effectiveDateTime = "2024-05-02T10:15:00Z"
* valueQuantity.value = 120
* valueQuantity.unit = "mg/dl"
* valueQuantity.system = $UCUM
* valueQuantity.code = #mg/dL

Instance: cgmSensorReadingMolarExample
InstanceOf: CGMSensorReadingMolar
Title: "CGM Sensor Reading (Molar) Example" 
Usage: #example
* status = #final
* code = $LNC#14745-4  
* subject = Reference(PatientExample)
* effectiveDateTime = "2024-05-02T10:30:00Z"
* valueQuantity.value = 6.7
* valueQuantity.unit = "mmol/l"
* valueQuantity.system = $UCUM
* valueQuantity.code = #mmol/L

Instance: cgmSummaryMeanGlucoseMassExample
InstanceOf: CGMSummaryMeanGlucoseMass
Title: "Mean Glucose (Mass) Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code.coding[0] = CGMSummaryCodesTemporary#mean-glucose-mass
* code.coding[1] = $LNC#97507-8
* valueQuantity.value = 145
* valueQuantity.unit = "mg/dl" 
* valueQuantity.system = $UCUM
* valueQuantity.code = #mg/dL

Instance: cgmSummaryMeanGlucoseMolarExample
InstanceOf: CGMSummaryMeanGlucoseMolar
Title: "Mean Glucose (Molar) Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01" 
* effectivePeriod.end = "2024-05-31"
* code = CGMSummaryCodesTemporary#mean-glucose-molar
* valueQuantity.value = 8.1
* valueQuantity.unit = "mmol/l"
* valueQuantity.system = $UCUM 
* valueQuantity.code = #mmol/L

Instance: cgmSummaryTimeInVeryLowExample 
InstanceOf: CGMSummaryTimeInVeryLow
Title: "Time in Very Low Range Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code = CGMSummaryCodesTemporary#time-in-very-low
* valueQuantity.value = 3
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryTimeInLowExample
InstanceOf: CGMSummaryTimeInLow
Title: "Time in Low Range Example" 
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code = CGMSummaryCodesTemporary#time-in-low
* valueQuantity.value = 8
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryTimeInTargetExample
InstanceOf: CGMSummaryTimeInTarget
Title: "Time in Target Range Example"
Usage: #example  
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code.coding[0] = CGMSummaryCodesTemporary#time-in-target
* code.coding[1] = $LNC#97510-2
* valueQuantity.value = 65 
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryTimeInHighExample
InstanceOf: CGMSummaryTimeInHigh
Title: "Time in High Range Example"
Usage: #example
* status = #final 
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code = CGMSummaryCodesTemporary#time-in-high
* valueQuantity.value = 20
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryTimeInVeryHighExample  
InstanceOf: CGMSummaryTimeInVeryHigh
Title: "Time in Very High Range Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample) 
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code = CGMSummaryCodesTemporary#time-in-very-high
* valueQuantity.value = 4
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryGMIExample
InstanceOf: CGMSummaryGMI  
Title: "GMI Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31" 
* code.coding[0] = CGMSummaryCodesTemporary#gmi
* code.coding[1] = $LNC#97506-0
* valueQuantity.value = 6.8
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryCoefficientOfVariationExample
InstanceOf: CGMSummaryCoefficientOfVariation
Title: "Coefficient of Variation Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code = CGMSummaryCodesTemporary#cv
* valueQuantity.value = 34
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryDaysOfWearExample
InstanceOf: CGMSummaryDaysOfWear
Title: "Days of Wear Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31" 
* code = CGMSummaryCodesTemporary#days-of-wear
* valueQuantity.value = 28
* valueQuantity.unit = "days"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummarySensorActivePercentageExample  
InstanceOf: CGMSummarySensorActivePercentage
Title: "Sensor Active Percentage Example" 
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* code = CGMSummaryCodesTemporary#sensor-active-percentage
* valueQuantity.value = 95
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #d

Instance: cgmSummaryExample
InstanceOf: CGMSummaryObservation
Title: "CGM Summary Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* code = CGMSummaryCodesTemporary#cgm-summary
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-31"
* hasMember[meanGlucoseMass] = Reference(cgmSummaryMeanGlucoseMassExample)
* hasMember[meanGlucoseMolar] = Reference(cgmSummaryMeanGlucoseMolarExample)  
* hasMember[timeInVeryLow] = Reference(cgmSummaryTimeInVeryLowExample)
* hasMember[timeInLow] = Reference(cgmSummaryTimeInLowExample)
* hasMember[timeInTarget] = Reference(cgmSummaryTimeInTargetExample)
* hasMember[timeInHigh] = Reference(cgmSummaryTimeInHighExample)
* hasMember[timeInVeryHigh] = Reference(cgmSummaryTimeInVeryHighExample)
* hasMember[gmi] = Reference(cgmSummaryGMIExample)
* hasMember[cv] = Reference(cgmSummaryCoefficientOfVariationExample)
* hasMember[daysOfWear] = Reference(cgmSummaryDaysOfWearExample)  
* hasMember[sensorActivePercentage] = Reference(cgmSummarySensorActivePercentageExample)

Instance: cgmSummaryPDFExample
InstanceOf: CGMSummaryPDF
Title: "CGM Summary PDF Report Example"
Usage: #example
* status = #final
* subject = Reference(PatientExample)
* effectivePeriod.start = "2024-05-01"
* effectivePeriod.end = "2024-05-14"
* presentedForm.contentType = #application/pdf
* presentedForm.data = "JVBERi0xLjAKJcK1wrYKCjEgMCBvYmoKPDwvVHlwZS9DYXRhbG9nL1BhZ2VzIDIgMCBSPj4KZW5kb2JqCgoyIDAgb2JqCjw8L0tpZHNbMyAwIFJdL0NvdW50IDEvVHlwZS9QYWdlcy9NZWRpYUJveFswIDAgNTk1IDc5Ml0+PgplbmRvYmoKCjMgMCBvYmoKPDwvVHlwZS9QYWdlL1BhcmVudCAyIDAgUi9Db250ZW50cyA0IDAgUi9SZXNvdXJjZXM8PD4+Pj4KZW5kb2JqCgo0IDAgb2JqCjw8L0xlbmd0aCA1OD4+CnN0cmVhbQpxCkJUCi8gOTYgVGYKMSAwIDAgMSAzNiA2ODQgVG0KKEZISVIgQ0dNISkgVGoKRVQKUQoKZW5kc3RyZWFtCmVuZG9iagoKeHJlZgowIDUKMDAwMDAwMDAwMCA2NTUzNiBmIAowMDAwMDAwMDE2IDAwMDAwIG4gCjAwMDAwMDAwNjIgMDAwMDAgbiAKMDAwMDAwMDEzNiAwMDAwMCBuIAowMDAwMDAwMjA5IDAwMDAwIG4gCgp0cmFpbGVyCjw8L1NpemUgNS9Sb290IDEgMCBSPj4Kc3RhcnR4cmVmCjMxNgolJUVPRgoK"

Instance: cgmDataSubmissionBundle
InstanceOf: CGMDataSubmissionBundle
Title: "CGM Data Submission Bundle Example"
Usage: #example
* meta.tag[cgmSubmissionBundle] = CGMCodes#cgm-data-submission-bundle
* type = #batch
* timestamp = "2024-05-02T14:30:00Z" 
* entry[+].resource = cgmSummaryPDFExample
* entry[=].fullUrl = "https://example.org/cgmSummaryPDFExample"
* entry[+].resource = cgmSummaryExample
* entry[=].fullUrl = "https://example.org/cgmSummaryExample"
* entry[+].resource = cgmSummaryMeanGlucoseMassExample
* entry[=].fullUrl = "https://example.org/cgmSummaryMeanGlucoseMassExample"
* entry[+].resource = cgmSummaryMeanGlucoseMolarExample
* entry[=].fullUrl = "https://example.org/cgmSummaryMeanGlucoseMolarExample"
* entry[+].resource = cgmSummaryTimeInVeryLowExample
* entry[=].fullUrl = "https://example.org/cgmSummaryTimeInVeryLowExample"
* entry[+].resource = cgmSummaryTimeInLowExample 
* entry[=].fullUrl = "https://example.org/cgmSummaryTimeInLowExample"
* entry[+].resource = cgmSummaryTimeInTargetExample
* entry[=].fullUrl = "https://example.org/cgmSummaryTimeInTargetExample"
* entry[+].resource = cgmSummaryTimeInHighExample
* entry[=].fullUrl = "https://example.org/cgmSummaryTimeInHighExample"
* entry[+].resource = cgmSummaryTimeInVeryHighExample
* entry[=].fullUrl = "https://example.org/cgmSummaryTimeInVeryHighExample"
* entry[+].resource = cgmSummaryGMIExample
* entry[=].fullUrl = "https://example.org/cgmSummaryGMIExample"
* entry[+].resource = cgmSummaryCoefficientOfVariationExample
* entry[=].fullUrl = "https://example.org/cgmSummaryCoefficientOfVariationExample"
* entry[+].resource = cgmSummaryDaysOfWearExample
* entry[=].fullUrl = "https://example.org/cgmSummaryDaysOfWearExample"
* entry[+].resource = cgmSummarySensorActivePercentageExample
* entry[=].fullUrl = "https://example.org/cgmSummarySensorActivePercentageExample"
* entry[+].resource = cgmSensorReadingMassExample
* entry[=].fullUrl = "https://example.org/cgmSensorReadingMassExample"
* entry[+].resource = cgmSensorReadingMolarExample
* entry[=].fullUrl = "https://example.org/cgmSensorReadingMolarExample"