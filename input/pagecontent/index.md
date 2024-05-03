### Introduction

The Argo Continuous Glucose Monitoring Implementation Guide provides a standardized approach for sharing CGM data between various systems and actors using the FHIR (Fast Healthcare Interoperability Resources) standard. This IG focuses on enabling the exchange of CGM data, including high-level reports and raw glucose observations, to support collaborative glucose management.

### User Stories

#### Patient-Mediated Data Sharing

Sarah, a type 1 diabetes patient, is switching to a new doctor. She has been using a CGM device and a patient app that stores her CGM data on her phone or in an app backend server. The app supports SMART on FHIR and is compatible with the Argo CGM IG. Sarah authorizes the app to connect with her new provider's EHR, using her patient portal credentials to grant access to the phone app. The app then sends Sarah's CGM reports from the past 3 months to the new provider's EHR using FHIR, ensuring her new doctor has access to her recent CGM history for informed decision-making.

#### Provider-Initiated Data Sharing

Dr. Johnson treats Michael, a type 2 diabetes patient struggling with glucose management. Dr. Johnson's practice uses "CloudCGM", a (fictional) cloud-based diabetes management platform that supports the Argo CGM IG.  Michael has a patient account in the CloudCGM platform, and a "Sharing Code" appears in his account settings. During a clinic visit, Dr. Johnson launches the CloudCGM SMART on FHIR app inside of his EHR, entering the sharing code as Michael reads it to him, This process establishes a linkage between Michael's records in the two systems. Now CloudCGM is able to submit data every week into Dr. Johnson's EHR, with results appearing in the native interface and easily incorporated into visit notes.

#### Patient Participation in Clinical Research

Dr. Patel is the principal investigator for a longitudinal research study. Participants are recruited from multiple diabetes management platforms that support the Argo CGM IG. The study protocol allows participants to share CGM data after completing an informed consent process. For consented participants, the diabetes management platforms submit a weekly data feed to a study server under Dr. Patel's control.  The standardized format and exchange protocols enable an efficient, multi-platform study focused on collecting raw glucose readings as part of the data package.

### Actors

#### Data Submitter

The data submitter can be either a user-facing app (patient or clinician) or a backend service. User-facing apps include mobile apps running on a patient's phone or a provider-facing app integrated into an Electronic Health Record (EHR) system. Backend services are "headless" systems that can write CGM data.

This IG also refers to Data Submitters as "apps" or "glucose management platforoms", since these are commonly understood terms.

#### Data Receiver

The data receiver is EHR system that receives and stores the CGM data submitted by the data submitter.

This IG also refers to Data Receivers as "EHRs", since this is a commonly understood term.

### Nominal Workflow
<img style="max-width: 400px; float: none;" src="flowchart.svg">

### Establishing Connections

#### Patient App to EHR

In this workflow, a patient-facing app connects directly to the EHR using the SMART on FHIR capabilities of the EHR. The app acts as a SMART on FHIR client and goes through an OAuth process where the patient approves the app to access their EHR, granting write scopes. This ensures that both the patient and the source EHR system agree to allow the app to write data using an appropriate access token.

**Technical Details**

* SMART on FHIR scopes that enable this scenario include:
  * `launch/patient`: patient app will already know who the patient is, and only requires a corresponding ID from the EHR
  * `patient/Patient.r`: it may still be desirable to cross-reference patient demographics, e.g. to confirm a match
  * `patient/ServiceRequest.rs?code=cgm-data-submission-standing-order`: helps app learn the EHR's data submission preferences
  * `patient/DiagnosticReport.cu?category=laboratory`: submit a summary report
  * `patient/Observation.cu?category=laboratory`: submit a summary observation or sensor reading
  * `patient/Device.cu`: submit device details associated with a sensor reading

#### Provider App to EHR

For provider-facing apps, the app can be integrated directly into the EHR's user interface using the SMART on FHIR EHR launch workflow. This workflow is widely supported by EHRs and allows apps to run within the EHR's creen rel estate. The EHR-integrated app might represent a device manufacturer or an independent glucose management platform. The app can retrieve the patient's ID and demographics from the EHR in real-time using the FHIR US Core Patient API.

To correlate the patient with a data record in the app's backend system, an in-brand or out-of-band process can be employed. Examples include:

1. A patient-facing companion app connects to the EHR using SMART on FHIR as in "Patient App to EHR," establishing a record linkage via API
2. A patient-facing companion app sends a push notification to the patient, asking if they want to establish a record linkage
3. A patient-facing companion app generates a sign-up code that the provider enters into the EHR.
4. The provider has an appropriate data sharing agreement in place with the app, allowing the app to match its patient list against  EHR-sourced demographics.

**Technical Details**

* SMART on FHIR scopes that enable this scenario include:
  * `launch/patient`
  * If using patient-level authorization
    * `patient/Patient.r`
    * `patient/ServiceRequest.rs?code=cgm-data-submission-standing-order`
    * `patient/DiagnosticReport.cu?category=laboratory`
    * `patient/Observation.cu?category=laboratory`
    * `patient/Device.cu`
  * If using user-level authorization
    * Same as above but `user/`
  * If using system-level authorization
    * Same as above but `system/`

### CGM Dats Submission: Bundles

**☛ See [Data Profile](StructureDefinition-cgm-data-submission-bundle.html#profile) for details**

**☛ See [Example CGM Data Submission Bundle](Bundle-cgmDataSubmissionBundle.json.html#root)**

{% include StructureDefinition-cgm-data-submission-bundle-header.xhtml %}

**Technical Details**

* CGM Submitters and Receivers SHALL support bundle-based submission, and MAY support individual resource submission
* CGM Receivers MAY choose to store only a subset of resources in a submitted bundle
  * Each entry in the `batch-response` bundle SHALL provide a status code indicating whether the submission was accepted 
  * Accepted entries SHOULD be available for read/search immediately after submission, but MAY be subjected to additional ingestion workflow steps

### CGM Data Submission: Standing Orders

**☛ See [Data Profile](StructureDefinition-cgm-data-submission-standing-order.html#profile) for details**

**☛ See [Example CHM Data Submission Order ("Send a summary every two weeks")](ServiceRequest-cgmDataSubmissionStandingOrderExample.json.html#root)**

{% include StructureDefinition-cgm-data-submission-standing-order-header.xhtml %}

**Technical Details**

* CGM Submitters SHOULD respect the Receivers' submission preferences
* CGM Receivers MAY
  * reject an entire submission Bundle if the frequency of submissions is too high
  * reject a subset of any submission Bundle (as documented above)