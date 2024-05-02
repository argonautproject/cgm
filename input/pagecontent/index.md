## Introduction

The Continuous Glucose Monitoring (CGM) Data Sharing Implementation Guide (IG) provides a standardized approach for sharing CGM data between various systems and actors using the FHIR (Fast Healthcare Interoperability Resources) standard. This IG focuses on enabling the exchange of CGM data, including high-level reports and raw glucose observations, to support effective collaboration between patients, healthcare providers, and researchers.

## User Stories

### Patient-Controlled Data Sharing
Sarah, a type 1 diabetes patient, is switching to a new doctor. She has been using a CGM device and a patient app that stores her CGM data on her phone. The app is compatible with the CGM Data Sharing IG. Sarah authenticates the app with her new provider's EHR, granting write access. The app then sends Sarah's CGM reports from the past 3 months directly from her phone to the new EHR using FHIR, ensuring her new doctor has access to her recent CGM history for informed decision-making.

### Automated Data Submission from Connected Apps
Emily, a pregnant woman with gestational diabetes, uses a CGM device connected to a compliant app. The app's backend service periodically sends Emily's CGM data to her obstetrician's EHR using FHIR, based on the EHR's configured preferences. The EHR automatically processes the data bundles, updating Emily's record. This helps keep Emily's obstetrician informed about her glucose levels throughout her pregnancy.

### Provider-Initiated Data Integration
Dr. Johnson treats Michael, a type 2 diabetes patient struggling with management. Michael uses a CGM device and diabetes app that displays a sign-up code. During an appointment, Michael provides the code to Dr. Johnson, who enters it into his EHR. The app, which supports the CGM Data Sharing IG, connects to Dr. Johnson's EHR and reads the EHR's preferences for data submission frequency and content. The app then sends Michael's CGM data to the EHR according to these preferences, enabling Dr. Johnson to analyze trends and provide personalized recommendations.

### Research Study on CGM Effectiveness
Dr. Patel conducts a study on CGM effectiveness in type 2 diabetes patients. Participants are recruited from multiple diabetes management platforms that implement the CGM Data Sharing IG. The research study server is configured as a data receiver, and the diabetes management platforms, which serve as data submitters, are set up to send CGM data directly to the server. Participants' CGM devices and apps send data, including raw glucose readings, to the platforms using FHIR. The platforms then submit the data to the research server according to the study's configured preferences. The research server aggregates and analyzes the received data to assess CGM impact on glycemic control and other outcomes. The standardized format and exchange protocols enable an efficient, multi-platform study focused on collecting raw glucose readings as part of the data package.

## Nominal Workflow
<img style="max-width: 400px; float: none;" src="flowchart.svg">

## Key Technical Actors

1. **Data Submitter**: The data submitter can be either a user-facing app (patient or clinician) or a backend service. User-facing apps include mobile apps running on a patient's phone or a provider-facing app integrated into an Electronic Health Record (EHR) system. Backend services are headless systems that can write CGM data.

2. **Data Receiver**: The data receiver is typically an EHR system that receives and stores the CGM data submitted by the data submitter.

## Establishing Connections

### Patient App to EHR

In this workflow, a patient-facing app connects directly to the EHR using the SMART on FHIR capabilities of the EHR. The app acts as a SMART on FHIR client and goes through an OAuth process where the patient approves the app to access their EHR, granting write scopes. This ensures that both the patient and the source EHR system agree to allow the app to write data using an appropriate access token.

### Provider App to EHR

For provider-facing apps, the app can be integrated directly into the EHR's user interface using the EHR launch workflow in SMART on FHIR. This workflow is widely supported by EHRs. The provider app can be an app representing a hardware manufacturer's cloud environment or a glucose data management platform. The app can retrieve the patient's ID and demographics from the EHR in real-time using the FHIR US Core Patient API.

To correlate the patient with a data record in the app's backend system, an out-of-band process can be employed. Examples include:

1. The patient app generates a sign-up code that the provider enters into the EHR.
2. The provider has a business associate agreement with the app, allowing for patient matching based on demographics. The app compares the demographics retrieved from the EHR against its database and suggests matches or indicates if adjudication is needed.

## Submitting CGM Data

Once an app is connected to the EHR, it can write data by POSTing a `batch` Bundle to the FHIR sever's submission endpoint. The EHR can recognize and handle these tagged bundles specially, while generic FHIR servers can process them as simple bundles at the POST Bundle endpoint. Bundles include a `meta.tag` of `"cgm-submission-bundle"` to help identify CGM Bundles, and the `entry` array includes any combination of CGM Summary Observations, CGM DiagnosticReport PDFs, and CGM Sensor Observation. 


**☛ See [CGM Submission Bundle](StructureDefinition-cgm-data-submission-bundle.html) for details**

### CGM Data Submission Standing Order

The Data Receiver can provide a standing order indicating:

* how often a Data Submitter should submit CGM data
* what specific data profiles the Data Submitter should include in each CGM Data Submission Bundle.

This standing order is modeled as a FHIR `ServiceRequest` resource. 

**☛ See [CGM Data Submision Standing Order](StructureDefinition-cgm-data-submission-standing-order.html) for details**

It's important to note that submissions can be manually triggered by a patient
or provider within their app. For example, if there is an upcoming appointment,
the provider can click a button to manually trigger submission of the most
up-to-date results. Out-of-band communication between the app developer and the
clinical provider system can also be used to establish preferred submission
schedules.

#### Example order: "Please Submit CGM Summary Statistics & PDF Every 2 weeks"

```json
{
  "resourceType": "ServiceRequest",
  "id": "cgm-data-submission-order",
  "status": "active",
  "intent": "order",
  "code": {
    "coding": [
      {
        "system": "http://argo.run/cgm/CodeSystem/cgm",
        "code": "cgm-submission-order",
        "display": "CGM Submission Order"
      }
    ]
  },
  "subject": {
    "reference": "Patient/example"
  },
  "extension": [
    {
      "url": "http://argo.run/cgm/StructureDefinition/data-submission-schedule",
      "extension": [
        {
          "url": "submissionFrequency",
          "valueTiming": {
            "repeat": {
              "frequency": 1,
              "period": 2,
              "periodUnit": "wk"
            }
          }
        },
        {
          "url": "submissionDataProfile",
          "valueCanonical": "http://argo.run/cgm/StructureDefinition/cgm-summary"
        },
        {
          "url": "submissionDataProfile",
          "valueCanonical": "http://argo.run/cgm/StructureDefinition/cgm-summary-pdf"
        }
      ]
    }
  ]
}
```


