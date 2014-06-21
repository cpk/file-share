<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="js/filesshare.js" type="text/javascript"></script>
</head>

<body>
<div id="signin">
  <div id="signin_top"><img src="img/logo.png" width="300" height="90"/>&nbsp;&nbsp;&nbsp; Create Account</div>
  <div id="signin_error">
  <%
  	String error = "";
	error = request.getParameter("error");
	if(error != null){
		if(error.compareTo("email") == 0){
			%>
			Invalid entry for email!
			<%	
		}else{
			if(error.compareTo("reemail") == 0){
				%>
				Confirm email is not correct!
				<%	
			}else{
				if(error.compareTo("pass") == 0){
					%>
					Invalid entry for password. 6 characters minumum!
					<%	
				}else{
					if(error.compareTo("repass") == 0){
						%>
						Confirm password is not correct!
						<%	
					}else{
						if(error.compareTo("exitsemail") == 0){
							%>
							Email is already exists!
							<%	
						}	
					}
				}
			}
		}
	}
  %>
  </div>
<div id="signin_cen">
  <form action="/signup" method="post" name="signin">
  <fieldset>
  <input name="firstname" id="firstname" type="text" tabindex="1" placeholder="First Name" size="19"/>&nbsp;&nbsp;
  <input name="lastname" type="text" tabindex="1" placeholder="Last Name" size="20"/><br />
  <input name="email" id="email" type="email" tabindex="1" placeholder="Email" size="50" onkeyup="checkEmail(this.value);"/><br />
  <div id="checkEmail"></div>
  <input name="password" id="password" type="password" tabindex="1" placeholder="Password" size="50" onkeyup="checkPass(this.value);"/><br />
  <div id="checkPass"></div>
  <textarea name="law" id="signUpTOS" class="inset-box" cols="43" rows="" readonly="readonly">Your Acceptance
This MediaFire Terms of Service, in conjunction with the Privacy Policy and other terms and conditions of use which are incorporated herein by reference and may be posted and applicable to specific services, governs your use of the MediaFire website, is a LEGALLY BINDING CONTRACT, and are collectively referred to as the "Agreement".
By visiting the MediaFire website, using any Content, products or services provided to you on, from, or through the MediaFire website (collectively the "Services") and/or by scrolling to the bottom of MediaFire's Terms of Service and clicking the "Accept" button, you are signifying that you have read the Agreement, that you understand the Agreement, and you agree to be bound by all of the terms of the Agreement. IF YOU DO NOT FULLY AND COMPLETELY AGREE TO THE TERMS OF THE AGREEMENT AND YOU, AS A RESPONSIBLE USER, CHOOSE TO CONTINUE TO USE THE SERVICES, YOU WILL BE BOUND TO THE TERMS OF THE AGREEMENT.
MediaFire may modify the Agreement which will become effective immediately upon its posting to the website. Your continued use of the website and any associated services indicates your acceptance of the Agreement and you agree to be bound by such modification or revisions. If you are dissatisfied with anything related to the MediaFire website, your sole remedy is to discontinue use of the Services. You use the Services of MediaFire at your own risk. Nothing in the Agreement shall be deemed to confer any third-party rights or benefits.
The Services
By visiting the MediaFire website, using any Content, products or services provided to you on, from, or through the MediaFire website or MediaFire products provided to any third party service or company for distribution, such as Apple's app store, (collectively the "Services").
The Agreement applies to all users of the Services, including users who contribute Content. "Content" includes text, software, scripts, graphics, photos, sounds, music, videos, audiovisual combinations, interactive features and other materials you may view on, access through, or contribute to the Services. The Services includes all aspects of MediaFire, including but not limited to, all products, software and services offered via the MediaFire website.
MediaFire may change, suspend or discontinue all or any aspect of the Services at any time, including the availability of any feature, database, or Content, without prior notice or liability.
MediaFire may contain links to third party websites. By use of the Services, you expressly relieve MediaFire from any and all liability arising from your use of any third-party website.
Light patterns, like those displayed when using the Services, may result in epileptic seizures in some people. Discontinue use of the Services, if advised by your physician or you experience epileptic symptoms.
MediaFire Accounts
To access or benefit from some of the Services or features on MediaFire, you will have to create a MediaFire account. You are responsible for maintaining the confidentiality of your access information and are responsible for all activities that occur utilizing your information. Although MediaFire will not be liable for any losses you might suffer, you may be liable for the losses of MediaFire or others
MediaFire Premium Accounts Terms and Conditions
PREMIUM SERVICES ARE AUTOMATICALLY RENEWED FOR SUCCESSIVE TERMS, EXCEPT THE YEARLY PLAN WHICH IS OFFERED FOR THE INITIAL 12 MONTHS ONLY AND WILL BEGIN BILLING MONTHLY STARTING THE 13TH MONTH AFTER SIGNUP, REQUIRING PERIODIC PAYMENTS, MONTHLY OR ANNUALLY, WITH RECURRING CREDIT CARD CHARGES OR OTHER PAYMENT METHOD SELECTED BY YOU, UNLESS TERMINATED OR CANCELLED BY YOU OR MEDIAFIRE AS PROVIDED IN THE AGREEMENT. You agree to pay all account charges and any applicable taxes and other fees that accrue in relation to your use of the Services. A more detailed description of premium services and the features can be found on the Product Matrix page.
You may cancel a subscription at any time through your My Account page. Your account will remain active for the remainder of the term for which you have previously paid after which it will revert to a standard free account and be subject to the restrictions of a free account. MediaFire may, without compensation or proration, cancel your subscription in the event of nonpayment or dispute of payment or if you violate any terms or conditions of the Agreement.
Premium services offer "Rollover Bandwidth". Unused bandwidth in each billing period will become available in subsequent billing periods, without time limitations for usage. You will be billed immediately for the new plan and any unused bandwidth from your previous plan will be Rolled over into your new plan. Additional increments of bandwidth may be purchased for immediate use, which qualifies as Rollover Bandwidth. This one time purchase is not a reoccurring charge and will not affect the pricing of your subscription service. You may view your billing history from your My Account page.
Bandwidth in a premium account is consumed by anyone, including you, who download your file(s). From your My Account page, you may view stats about your bandwidth usage, which take several hours to process from the moment of access.
Refund Policy:
MediaFire offers a thirty (30) day money-back guarantee which only applies to the initial charge of your first subscription with MediaFire. The guarantee does not apply to re-established subscriptions, changes in subscriptions or creations of subsequent subscriptions. Details of usage, purchases, and other factors determine if a user qualifies for a refund when requested.
ALL REFUND REQUESTS are handled on a case-by-case basis. If you feel you are due a refund, contact MediaFire by email at refund@mediafire.com.
Authorized Resellers:
MediaFire has an Authorized Reseller Program to provide users an alternate means of purchasing MediaFire Services. These Authorized Resellers are not employees of MediaFire and do not conclude any contracts on behalf of MediaFire. Users who purchase MediaFire Services through an Authorized Reseller are still bound by and subject to the MediaFire Agreement. A list of Authorized Resellers can be viewed at the Resellers page. Users should NOT purchase MediaFire Services from any third party not listed as an Authorized Reseller on our website. MediaFire Services cannot be activated if purchased outside the scope of this program or from MediaFire itself.
The Authorized Resellers purchase MediaFire Services in increments available only to resellers and offer the MediaFire Services to users for purchase. The purchase transaction itself is a contractual relationship solely between their Authorized Reseller and the user who purchased MediaFire Services from them. MediaFire is not responsible for Authorized Reseller billing questions or concerns, therefore, PURCHASE AND BILLING QUESTIONS SHOULD BE DIRECTED TO THE AUTHORIZED RESELLER. Services normally provided by MediaFire for MediaFire users, including, but not limited to, technical support, will still be provided by MediaFire Customer Support. Concerns or complaints about an Authorized Reseller should be reported to our support department.
General Use of the Service, Permissions and Restrictions
You agree while using MediaFire Services, that you may not:
Alter or modify any part of the Services;
Use the Services for any illegal purpose;
Use any robot, spider, offline readers, site search and/or retrieval application, or other device to retrieve or index any portion of the Services, with the exception of public search engines;
Transmit any viruses, worms, defects, Trojan horses or other items of a contaminating or destructive nature;
Upload any Content that includes code hidden or otherwise contained within the Content which is unrelated to the Content;
Reformat or frame any portion of any web page that is part of the Services without the express permission of MediaFire;
Collect or harvest any personal identifiable information or account names or solicit users;
Impersonate another person, whether real or fictional;
Permit any third parties to use your name and password;
Violate or attempt to violate MediaFire systems or interfere with the normal use of the Services by users;
Without a Reseller account granted solely by MediaFire, resale MediaFire's products and Services;
Post advertisements, promotions or solicitations of business;
Transmit any form of solicitation or Spam;
Submit any Content that falsely implies sponsorship of the Content by the Services, falsify or delete any author attribution in any Content, or promote any information that you know is false or misleading;
Distribute an illegal or unauthorized copy of another person's trademarked or copyrighted work;
Distribute Content that is libelous, defamatory, obscene, pornographic, abusive, harassing, threatening, unlawful or promotes or encourages illegal activity;
Distribute Content that violates the rights of others, such as distributing Content that infringes any copyright, trademark, patent, trade secret or violates any right of privacy or publicity, or that is libelous or defamatory, or that directs any user to the content of a third party without consent of the third party;
Defame or libel any person; invade any person's right of privacy or publicity or otherwise violate, misappropriate or infringe the rights of any person;
Export or re-export Content in violation of the export or import laws of the United States or without all required approvals, licenses and exemptions;
Post any links to any external Internet sites that are obscene or pornographic, or display pornographic or sexually explicit material of any kind.
Your Use of the Content
In addition to the general restrictions above, the following restrictions and conditions apply specifically to your use of the Content. You will comply with laws regarding transmission of data.
Content is provided to you AS IS. You understand that when using the Services, you will be exposed to Content from a variety of sources, and that MediaFire is not responsible for the accuracy, usefulness, safety, or intellectual property rights of or relating to such Content. You further understand and acknowledge that you may be exposed to Content that is inaccurate, offensive, indecent, or objectionable, and you agree to waive, and hereby do waive, any legal or equitable rights or remedies you have or may have against MediaFire with respect thereto, and, to the extent permitted by applicable law, agree to indemnify and hold harmless MediaFire, its owners, operators, affiliates, licensors, and licensees to the fullest extent allowed by law regarding all matters related to your use of the Services. You acknowledge your use of Content is at your sole risk.
MediaFire Content may contain links to external sites; however, MediaFire is not responsible for any availability of or the content on or through any external site.
Your Content and Conduct
You shall be solely responsible for your own content and the consequences of storing or distributing your Content on the Services. You affirm, represent, and warrant that you own or have the necessary licenses, rights, consents, and permissions to distribute Content through the Services; and you provide a limited license to MediaFire in and to such Content solely for distribution on the Services pursuant to the Agreement.
For clarity, you retain all of your ownership rights in your Content. We don't claim any ownership in or to your Content. Nothing in this Agreement grants us any rights to your Content. When you use MediaFire Services, to enable MediaFire to provide the Services, it is necessary for you to hereby grant MediaFire a worldwide, non-exclusive, royalty-free, sub-licensable and transferable limited license to use, reproduce, distribute, prepare derivative works of, display, perform the Content in connection with the Services and MediaFire's (and its successors and affiliates) business. MediaFire does not endorse any Content stored on or distributed through the Services and MediaFire expressly disclaims any and all liability in connection with Content. You bear full responsibility and sole liability for any lost or irrecoverable data. You understand and agree that MediaFire reserves the right to delete, move, archive (including account information) or edit any Content that it may determine violates the Agreement and/or Privacy Policy or is otherwise unacceptable and may terminate your access to the Services, without prior notice and at its sole discretion.
You control your data through your free or Premium account and/or cookies which may be placed on your computer. MediaFire maintains multiple copies of active files. MediaFire bears no responsibility for maintaining your data indefinitely.
You are solely responsible for your interactions with other users of the Services. Any views expressed on the website do not reflect the views of MediaFire.
Account Termination Policy
Anyone using MediaFire Services must comply with the MediaFire Agreement and Privacy Policy. Anyone, including business entities, not in compliance may be removed and banned from the Services without prior notice. MediaFire reserves the right to terminate your access to any and/or all parts of the Services at any time for any reason without prior notice or liability. The terms of the Agreement and Privacy Policy shall survive any termination of your access to the Services.
When MediaFire removes Content for policy violations, the user who posted the Content may receive a strike. The user is notified of the violation via email. Repeated policy violations may result in account termination. MediaFire reserves the right to determine what is harmful to its users, operations or reputation, including any activities that restrict or inhibit any other user from using and enjoying the Services. Complaints about violators of our policies should be submitted to our support department. Each complaint will be investigated and appropriate action will be taken.
DMCA: Digital Millennium Copyright Act
If your copyrighted or trademarked works are being distributed through the Services without your permission, please submit a ticket to our support department, and describe the work that has been infringed, where it is located on the website, and provide your contact information and a statement, made under penalty of perjury, that the information in your notice is accurate and that you are the owner, or authorized by the owner, of the copyrighted or trademarked work. Valid requests will be serviced after notice with sufficient information.
For more information, please see Copyright.
Warranty Disclaimer
YOU AGREE THAT YOUR USE OF THE SERVICES SHALL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, MEDIAFIRE, ITS OFFICERS, DIRECTORS, EMPLOYEES, AND AGENTS DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE SERVICES AND YOUR USE THEREOF.
NEITHER MEDIAFIRE NOR ANY PROVIDER OF ANY THIRD PARTY CONTENT WARRANTS THAT THE SERVICES WILL BE UNINTERRUPTED OR ERROR FREE OR MAKES ANY WARRANTY OF THE RESULTS TO BE OBTAINED FROM USE OF THE SERVICES OR CONTENT. BOTH THE SERVICES AND CONTENT ARE DISTRIBUTED ON AN "AS IS, AS AVAILABLE" BASIS. NEITHER MEDIAFIRE NOR ANY THIRD PARTY MAKES ANY WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, WARRANTIES OF TITLE OR IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, WITH RESPECT TO THE SERVICES OR CONTENT OR ANY PRODUCTS OR SERVICES SOLD THROUGH THE SERVICES.
NEITHER MEDIAFIRE NOR ANY THIRD PARTY WARRANT THAT ANY FILES AVAILABLE FOR DOWNLOADING THROUGH THE SERVICES WILL BE FREE OF VIRUSES OR SIMILAR CONTAMINATION OR DESTRUCTIVE FEATURES. YOU AGREE THAT YOU ASSUME ALL RISK AS TO THE QUALITY AND PERFORMANCE OF THE SERVICES AND THE ACCURACY AND COMPLETENESS OF THE CONTENT. MEDIAFIRE IS NOT RESPONSIBLE OR LIABLE FOR ANY UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR CONTENT OR FOR ANY VIOLATION OF ITS AGREEMENT.
FOR CLARITY, MEDIAFIRE ASSUMES NO LIABILITY OR RESPONSIBILITY FOR ANY (I) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT, (II) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF OUR SERVICES, (III) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (IV) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM OUR SERVICES, (IV) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH OUR SERVICES BY ANY THIRD PARTY, AND/OR (V) ANY ERRORS OR OMISSIONS IN ANY CONTENT OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, EMAILED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SERVICES. MEDIAFIRE DOES NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SERVICES OR ANY HYPERLINKED SERVICES OR FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND MEDIAFIRE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION.
Limitation of Liability
NEITHER MEDIAFIRE NOR ANY THIRD PARTY PROVIDER SHALL BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR PUNITIVE DAMAGES WHATSOEVER ARISING OUT OF THE USE OF OR INABILITY TO USE THE SERVICES, EVEN IF SUCH PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. IN NO EVENT WILL MEDIAFIRES AGGREGATE LIABILITY TO YOUR OR ANY THIRD PARTY FOR ANY AND ALL CLAIMS ARISING OUT OF OR IN CONNECTION WITH THE USE OF THE SERVICES EXCEED ONE HUNDRED DOLLARS ($100). THE LIMITATIONS OF DAMAGES SET FORTH ABOVE ARE FUNDAMENTAL ELEMENTS OF THE BASIS OF THE BARGAIN BETWEEN MEDIAFIRE AND YOU. IN STATES NOT ALLOWING EXCLUSION OF IMPLIED WARRANTIES OR LIMITATION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES, MEDIAFIRE AND ANY THIRD PARTY PROVIDER SHALL BE LIMITED TO THE GREATEST EXTENT OF THE LAW.
The Services are controlled and offered by MediaFire from its facilities in the United States of America. MediaFire makes no representations that the Services are appropriate or available for use in other locations. Those who access or use the Services from other jurisdictions do so at their own volition and are responsible for compliance with local law.
Indemnity
You agree to indemnify, defend and hold MediaFire and its affiliates, and both MediaFire and their respective officers, directors, owners, employees, agents, information providers and licensors harmless from and against any and all claims, liability, losses, damages, obligations, costs and expenses, including attorney's fees, incurred by any MediaFire Party in connection with any Content or use of the Services, whether via your password and by any other person, whether or not authorized by you. MediaFire reserves the right, at its own expense, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you, and in such case, you agree to cooperate with MediaFire's defense of such claim. This defense and indemnification obligation will survive these Terms of Service and your use of the Services.
Ability to Accept Terms of Service
MediaFire Free Services are available to anyone over the age of 13, in observance of and compliance with the Children's Online Privacy Protection Act. If you are under 13 years of age, then please do not use the Service. There are lots of other great web sites for you. Talk to your parents about what sites are appropriate for you.
MediaFire premium services are available to anyone over the age of 18.
Accounts for business entities must be created and maintained by an individual capable of and authorized to enter into binding contracts on behalf of the entity. You affirm that you are fully able and competent to enter into the terms, conditions, obligations, affirmations, representations, and warranties set forth in the Agreement, and to abide by and comply with these Terms of Service.
Assignment
These Terms of Service, and any rights and licenses granted hereunder, may not be transferred or assigned by you, but may be assigned by MediaFire without restriction.
General
The Agreement shall be construed in accordance with the laws of the State of Texas, without reference to principles of choice of law. You and MediaFire each irrevocably consent to the personal jurisdiction of the federal or state courts located in Harris County, Texas ("Courts") with respect to any action, suit or proceeding arising out of or related to the Agreement or to the Services and /or Content and waive any objection to venue in any of the Courts for such as action, suit or proceeding; additionally, you agree that you will not bring any such action, suit or proceeding in any court other than the Courts.
These Terms of Service, together with the Privacy Policy and any other legal notices published by MediaFire on the Services, the Agreement, constitutes the entire agreement between the parties with respect to the subject matter hereof, and supersedes all previous written or oral agreements between the parties with respect to such subject matter. If any inconsistency exists between the terms of the Agreement and any additional terms and conditions posted on the Services, such terms shall be interpreted as to eliminate any inconsistency, if possible, and otherwise, the additional terms and conditions shall control. If any provision of the Agreement is held invalid, illegal or unenforceable in any respect, (i) such provision shall be interpreted in such a manner as to preserve, to the maximum extent possible, the intent of the parties, (ii) the validity, legality and enforceability of the remaining provisions shall not in any way be affected or impaired thereby, and (iii) such decision shall not affect the validity, legality or enforceability of such provision under other circumstances.
No failure in delay in exercising or enforcing this policy shall constitute a waiver of the Agreement or any other right or remedy. If any provision of the Agreement is deemed unenforceable due to law or change in law, such a provision shall be disregarded and the balance of the Agreement shall remain in effect.
YOU AND MEDIAFIRE AGREE THAT ANY CAUSE OF ACTION ARISING OUT OF OR RELATED TO THE SERVICES MUST COMMENCE WITHIN ONE (1) YEAR AFTER THE CAUSE OF ACTION ARISES, OTHERWISE, SUCH CAUSE OF ACTION IS PERMANENTLY BARRED.
Please submit reports of any violations to our support department.
Revised: January 17, 2013</textarea><br />
  <input name="agree" type="checkbox" value="1"/>I agree to the Terms of Service.<br />
  <input id="signup_continue" class="gbtnTertiary" type="submit" value="Create Account & Continue" name="signup_continue" />  
  </fieldset>
  </form>
</div>
</div>
<div id="signin_bot">©2013 MediaFire  Build 94734 Need help? Call us at 1-877-688-0068 or submit a ticket. </div>
</body>
</html>
