import 'dart:io';


class AppConstants {
  static const String APP_NAME = 'Kredit Option';
  static const String APP_EMAIL = 'kreditoption@gmail.com';
  static const String APP_DESCRIPTION = 'Kredit Option Description';
  static const String BASE_URL = 'https://service.kreditoptionz.com:2918/';
  static const String MENU_URI = 'api/v1/menu/list';
  static const String LOAN_TYPE_URI = 'api/v1/loan-type/list';
  static const String Notification_URI = 'api/v1/notifications';
  static const String LOAN_DETAILS_URI = 'api/v1/loan-panel/';
  static const String LOAN_PANEL_LIST_URI = 'api/v1/loan-panel/list';
  static const String ADMIN_BANK_URI = 'api/v1/admin-bank';
  static const String LOAN_STEPS_URI = 'api/v1/loan-panel/';
  static const String PAYMENT_HISTORY_CHARGE_URI = 'api/v1/payment-history/charge/';
  static const String PAYMENT_HISTORY_EMI_URI = 'api/v1/payment-history/emi/';
  static const String UPLOAD_CREDIT_SCORE_URI = 'api/v1/credit-score/';
  static const String MENU_CALCULATE_URI = 'menu-calculate';
  static const String LOAN_PROFILE_URI = 'loan-profile';
  static const String MY_LOAN_PROFILE_URI = 'loan-profile/my_loan_profile/';
  static const String LOAN_LIST = 'loan-panel';
  static const String APPLY_LOAN = 'user-loan';
  static const String CONFIG_URI = 'aadhar_card/';
  static const String TRACK_URI = 'pan_card/';
  static const String MESSAGE_URI = 'passbook/';
  static const String MY_LOAN_LIST = 'user-loan/my_loans';
  static const String LOGIN_USER_URI = 'auth/user';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String CHECK_PHONE_URI = 'api/v1/auth/check-phone?phone=';
  static const String VERIFY_PHONE_URI = 'auth/verify_otp';
  static const String UPDATE_USER_URI = 'user/';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String REGISTER_URI = '/api/v1/auth/register';

  static const String LOGIN_URI = 'api/v1/auth/login';
  static const String LOAN_APPLY = 'api/v1/loan-panel';
  static const String LOAN_UPDATE = 'api/v1/loan-panel/';
  static const String PERSONAL_DETAILS='api/v1/personal-details/';
  static const String SIGNATURE_DETAILS='api/v1/loan-panel/signature/';
  static const String KYC_DETAILS='api/v1/kyc-details/';
  static const String KYC_DETAILS_AADHAR_FRONT='api/v1/kyc-details/aadhar-front/';
  static const String KYC_DETAILS_AADHAR_BACK='api/v1/kyc-details/aadhar-back/';
  static const String KYC_DETAILS_PAN_FRONT='api/v1/kyc-details/pan-front/';
  static const String KYC_DETAILS_PAN_BACK='api/v1/kyc-details/pan-back/';
  static const String KYC_DETAILS_PASSBOOK='api/v1/bni-details/passbook/';
  static const String KYC_DETAILS_SLIP='api/v1/bni-details/slip/';

  static const String INCOME_DETAILS='api/v1/bni-details/';
  static const String INSURANCE_DETAILS='api/v1/insurance-details/';

  static const String CITY_URI = 'city';
  static const String MY_PROPERTY_URI = 'property/my_property/';
  static const String HOME_PROPERTY_URI = 'property/home/';
  static const String PROPERTY_DETAILS_URI = 'property/';
  static const String FAVOURITE_PROPERTY_URI = 'favorite-property';
  static const String UPLOAD_IMAGE_URI = 'property-image/uploads/';
  static const String LOCALITY_URI = 'locality';
  static const String PAGE_URI = 'pages/';
  static const String ADDPROPERTY = 'property';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String LOAN_ID = 'loan_id';
  static const String LOAN_STATUS = 'loan_status';
  static const String LOAN_Charge= 'loan_charge';
  static const String LOAN_Type= 'loan_type';
  static const String PAYMENT_STATUS = 'payment_status';
  static const String CREDIT_STATUS = 'credit_status';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String login = 'login';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String USERID = 'user_id';
  static const String USER = 'user';
  static const String DEVICEID = 'device_id';
  static const String VERIFICATIONID = 'verification_id';
  static const String RUPEE = '\₹';

  static  String USER_TYPE = '';
  static  String USERNAME = '';
  static  String EMAIL = '';
  static  String LOCALITY = '';
  static  String CITY = '';
  static  String CITYID = '0';
  static  String LOCALITYID = '0';
  static  String PROPERTY_TYPE = '';
  static  String HOME_TYPE = '';
  static  String FLAT_TYPE = '1BHK';

  static const String first_time = 'first_time';
  static const String POPPINS = "Poppins";
  static const String OPEN_SANS = "OpenSans";
  static const String SKIP = "Skip";
  static const String NEXT = "Next";
  static const String SLIDER_HEADING_1 = "ONE-STOP SOLUTION FOR\nALL YOUR EMI CALCULATION";
  static const String SLIDER_HEADING_2 = "QUICK ONLINE INSTANT\nLOAN APPLICATION";
  static const String SLIDER_HEADING_3 = "YOU CAN GET A LOAN FROM :\n₹50,000 - ₹10,00,000";
  static const String SLIDER_DESC_1 = "This smart and handy app is a one-stop\nsolution for your financial calculation";
  static const String SLIDER_DESC_2 = "100% Safe & secure loan application with\nminimum documentation for all your needs.  ";
  static const String SLIDER_DESC_3 = "FAST, EASY & SECURE";

  static String TERMS="I acknowledge that I have  understood & agree with the fact that KreditOption will not be liable to share the reasons for the loan application's "
      "result such as rejection,delay in processing after the application is submitted to KreditOption."+
  "I also confirm that I am agree to pay the document verification charges of Rs. 485 as I am enjoying the service of KreditOption which is not directly involved in lending activities and only provides a platform to help Non-Banking Finance Companies (NBFCs) lend money to users, KreditOption works with RBI authorized and regulated NBFCs/financial institutions."+
  "I also acknowledge that there will be no refund of the fees( rs. 485) paid for the verification of all documents provided by me & checking the eligibility of my loan application, in all instances, including when my loan is rejected or disapproved - because the loan is completely depending on my profile & credit eligibility criteria of LOAN PROVIDER as per their rules & regulations."+
  "I confirmed that I have read , understood & agree with the above statement.";

  static String TERMSANDCONDITION="TERMS AND CONDITIONS OF EMI CALCULATOR\n"+

      " Last updated October 10, 2022\n"+



      "EMI CALCULATOR is licensed to You (End-User) by EMI CALCULATOR, located and registered at SANTIPUR, WEST BENGAL, India ('Licensor'), for use only under the terms of this Licence Agreement.\n"+

      "By downloading the Licensed Application from Google's software distribution platform ('Play Store), and any update thereto (as permitted by this Licence Agreement), You indicate that You agree to be bound by all of the terms and conditions of this Licence Agreement and that You accept this Licence Agreement. Play Store is referred to in this Licence Agreement as 'Services'.\n"+

      "The parties of this Licence Agreement acknowledge that the Services are not a Party to this Licence Agreement and are not bound by any provisions or obligations with regard to the Licensed Application, such as warranty, liability, maintenance, and support thereof EMI CALCULATOR, not the Services, is solely responsible for the Licensed Application and the content thereof.\n"+

      "This Licence Agreement may not provide for usage rules for the Licensed Application that are in conflict with the latest Google Play Terms of Service ('Usage Rules').  acknowledges that it had the opportunity to review the Usage Rules and this Licence Agreement is not conflicting with them.\n"+

      "EMI CALCULATOR when purchased or downloaded through the Services is licensed to You for use only under the terms of this Licence Agreement. The Licensor reserves all rights not expressly granted to You. EMI CALCULATOR is to be used on devices that operate with Google's operating system ('Android').\n"+


      "TABLE OF CONTENTS\n"+

      "1. THE APPLICATION\n"+
      "2. SCOPE OF LICENCE\n"+
      "3. TECHNICAL REQUIREMENTS\n"+
      "4. MAINTENANCE AND SUPPORT\n"+
      " 5. USE OF DATA\n"+
      "6. USER-GENERATED CONTRIBUTIONS\n"+
      "7. CONTRIBUTION LICENCE\n"+
      "8. LIABILITY\n"+
      " 9. WARRANTY\n"+
      " 10. PRODUCT CLAIMS\n"+
      "11. LEGAL COMPLIANCE\n"+
      "12. CONTACT INFORMATION\n"+
      " 13. TERMINATION\n"+
      "14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY\n"+
      "15. INTELLECTUAL PROPERTY RIGHTS\n"+
      "16. APPLICABLE LAW\n"+
      "17. MISCELLANEOUS\n"+


      " 1. THE APPLICATION\n"+

      " EMI CALCULATOR ('Licensed Application') is a piece of software created to EMI CALCULATE AND Customized— and customised for Android mobile devices ('Devices'). It is used to the loan provided to user.\n"+


      " 2. SCOPE OF LICENCE\n"+

      "2.1  You are given a non-transferable, non-exclusive, license to install and use the Licensed Application on any Devices that You (End-User) own or control and as permitted by the Usage Rules, with the exception that such Licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing.\n"+

      "2.2  licensee will also govern any updates of the Licensed Application ion provided by Licensor that replaces, repair, and/or supplement the first Licensed Application, unlicensed the is provided for such update, in which case the license of that new licence will govern.\n"+

      "2.3  You may not share or make the Licensed Application available to third parties (unless to the degree allowed by the Usage Rules, and with EMI CALCULATOR prior written consent), sell, rent, lend, lease or otherwise redistribute the Licensed Application.\n"+

      "2.4  You may not reverse engineer, translate, disassemble, integrate, decompile, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Licensed Application, or any part thereof (except with EMI CALCULATOR prior written consent).\n"+


      "3. TECHNICAL REQUIREMENTS\n"+

      "3.1  The Licensed Application requires a firmware version 1.0.0 or higher. Licensor recommends using the latest version of the firmware.\n"+

      "3.2  Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.\n"+


      "4. MAINTENANCE AND SUPPORT\n"+

      "4.1  The Licensor is solely responsible for providing any maintenance and support services for this Licensed Application. You can reach the Licensor at the email address listed in the Play Store Overview for this Licensed Application.\n"+

      "4.2  EMI CALCULATOR and the End-User acknowledge that the Services have no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application.\n"+


      "5. USE OF DATA\n"+

      "You acknowledge that Licensor will be able to access and adjust Your downloaded Licensed Application content and Your personal information and that Lithe censor's use of such material and information is subject to Your legal agreements with Licensor and Licensor's privacy policy, which can be accessed by\n"+

      "You acknowledge that the Licensor may periodically collect and use technical data and related information about your device, system, and application software, and peripherals, offer product support, facilitate the software updates, and for purposes of providing other services to you (if any) related to the Licensed Application. Licensor may also use this information to improve its products or to provide services or technologies to you, as long as it is in a form that does not personally identify you.\n"+


      "6. USER-GENERATED CONTRIBUTIONS\n"+

      "The Licensed Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Licensed Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Licensed Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:\n"+

      "1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.\n"+
      "2. You are the creator and owner of or licenses, rights, consents, releases, and permissions authorized to authorize us, the Licensed Application, and other users of the Licensed Application to use your Contributions in any manner contemplated by the Licensed Application and this Licence Agreement.\n"+
      "3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Licensed Application and this Licence Agreement.\n"+
      "4. Your Contributions are not false, inaccurate, or misleading.\n"+
      "5. Your Contributions are not unauthorized or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.\n"+

      "Any use of the Licensed Application in violation of the foregoing violates this Licence Agreement and may result in, among other things, termination or suspension of your rights to use the Licensed Application.\n"+


      "7. CONTRIBUTION LICENCE\n"+

      "By posting your Contributions to any part of the Licensed Application or making Contributions accessible to the Licensed Application by linking your account from the Licensed Application to any of your social networking accounts, you automatically  and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and licence to host, use copy, reproduce, disclose, sell, resell, broadcast .road cast, retitle, archive, store, cache, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial advertising, or otherwise, and to prepare derivative works of, or incorporate in other works, such as Contributions, and authorized. The use and distribution may occur in format and through any media channels.\n"+

      "License will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions.\n"+

      "We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area in the Licensed Application. You are solely responsible for your Contributions to the Licensed Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.\n"+

      "We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; any Contributions to place in more appropriate locations in the Licensed Application; and (3) to pre screen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions.\n"+


      "8. LIABILITY\n"+

      "8.1  Licensor's responsibility in the case of violation of obligations and tort shall be limited to intent and gross negligence. Only in case of a breach of essential contractual duties (cardinal obligations), Licensor shall also be liable in case of slight negligence. In any case, liability shall be limited to the foreseeable, contractually typical damages. The limitation mentioned above does not apply to injuries to life, limb, or health.\n"+

      "10. PRODUCT CLAIMS\n"+

      "EMI CALCULATOR and the End-User acknowledge that EMI CALCULATOR, and not the Services, is responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the End-User’s possession and/or use of that Licensed Application, including, but not limited to:\n"+

      "(i) product liability claims;\n"+

      "(ii) any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and\n"+

      "(iii) claims arising under consumer protection, privacy, or similar legislation.\n"+


      "11. LEGAL COMPLIANCE\n"+

      "You represent and warrant that You are not located in a country that is subject to a US Government embargo, or that has been designated by the US Government as a 'terrorist supporting' country; and that You are not listed on any US Government list of prohibited or restricted parties.\n"+


      "12. CONTACT INFORMATION\n"+

      "For general inquiries, complaints, questions or claims concerning the Licensed Application, please contact:\n"+

      "sujoy dey\n"+
      "Santipur, WEST BENGAL\n"+
      "India\n"+
      "deysujoy29@gmail.com\n"+


      "13. TERMINATION\n"+

      "The licence is valid until terminated by EMI CALCULATOR or by You. Your rights under this licence will terminate automatically and without notice from EMI CALCULATOR if You fail to adhere to any term(s) of this licence. Upon Licence termination, You shall stop all use of the Licensed Application, and destroy all copies, full or partial, of the Licensed Application.\n"+


      "14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY\n"+

      "EMI CALCULATOR represents and warrants that EMI CALCULATOR will comply with applicable third-party terms of agreement when using Licensed Application.\n"+

      "In Accordance with Section 9 of the 'Instructions for Minimum Terms of Developer's End-User Licence Agreement', Google's subsidiaries shall be third-party beneficiaries of this End User Licence Agreement and — upon Your acceptance of the terms and conditions of this Licence Agreement, Google will have the right (and will be deemed to have accepted the right) to enforce this End User Licence Agreement against You as a third-party beneficiary thereof.\n"+


      "15. INTELLECTUAL PROPERTY RIGHTS\n"+
      "EMI CALCULATOR and the End-User acknowledge that, in the event of any third-party claim that the Licensed Application or the End-User's possession and use of that Licensed Application infringes on the third party's intellectual property rights, EMI CALCULATOR, and not the Services, will be solely responsible for the investigation, defence, settlement, and discharge or any such intellectual property infringement claims.\n"+


      "16. APPLICABLE LAW\n"+

      "This Licence Agreement is governed by the laws of India excluding its conflicts of law rules.\n"+


  "17. MISCELLANEOUS\n"+

  "17.1  If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose.\n"+

  "17.2  Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing.";
}
