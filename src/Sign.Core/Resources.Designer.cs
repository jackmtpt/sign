﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sign.Core {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "17.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class Resources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Sign.Core.Resources", typeof(Resources).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Signing SignTool job with {count} files..
        /// </summary>
        internal static string AzureSignToolSignatureProviderSigning {
            get {
                return ResourceManager.GetString("AzureSignToolSignatureProviderSigning", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to The certificate is expired..
        /// </summary>
        internal static string CertificateIsExpired {
            get {
                return ResourceManager.GetString("CertificateIsExpired", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to The certificate is not yet time valid..
        /// </summary>
        internal static string CertificateIsNotYetTimeValid {
            get {
                return ResourceManager.GetString("CertificateIsNotYetTimeValid", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Signing Mage job with {count} files..
        /// </summary>
        internal static string ClickOnceSignatureProviderSigning {
            get {
                return ResourceManager.GetString("ClickOnceSignatureProviderSigning", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {fileName} returned the error {error}.
        /// </summary>
        internal static string CliStandardError {
            get {
                return ResourceManager.GetString("CliStandardError", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {fileName} returned the output {output}.
        /// </summary>
        internal static string CliStandardOutput {
            get {
                return ResourceManager.GetString("CliStandardOutput", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Creating directory {path}..
        /// </summary>
        internal static string CreatingDirectory {
            get {
                return ResourceManager.GetString("CreatingDirectory", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Directory {path} deleted..
        /// </summary>
        internal static string DeletedDirectory {
            get {
                return ResourceManager.GetString("DeletedDirectory", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Deleting directory {path}..
        /// </summary>
        internal static string DeletingDirectory {
            get {
                return ResourceManager.GetString("DeletingDirectory", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Directory {path} still exists..
        /// </summary>
        internal static string DirectoryNotDeleted {
            get {
                return ResourceManager.GetString("DirectoryNotDeleted", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Editing AppInstaller job with {count} files..
        /// </summary>
        internal static string EditingAppInstaller {
            get {
                return ResourceManager.GetString("EditingAppInstaller", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to An unspecified error occurred during VSIX signing..
        /// </summary>
        internal static string ErrorSigningVsix {
            get {
                return ResourceManager.GetString("ErrorSigningVsix", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to An exception occurred while attempting to delete directory {path}..
        /// </summary>
        internal static string ExceptionWhileDeletingDirectory {
            get {
                return ResourceManager.GetString("ExceptionWhileDeletingDirectory", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Fetched certificate. [{milliseconds} ms].
        /// </summary>
        internal static string FetchedCertificate {
            get {
                return ResourceManager.GetString("FetchedCertificate", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Fetching certificate from Azure Key Vault..
        /// </summary>
        internal static string FetchingCertificate {
            get {
                return ResourceManager.GetString("FetchingCertificate", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Extracting container {ContainerFilePath} to {DirectoryPath}..
        /// </summary>
        internal static string OpeningContainer {
            get {
                return ResourceManager.GetString("OpeningContainer", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {0} timed out and could not be killed..
        /// </summary>
        internal static string ProcessCouldNotBeKilled {
            get {
                return ResourceManager.GetString("ProcessCouldNotBeKilled", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {fileName} took too long to respond. The process exit code is {exitCode}..
        /// </summary>
        internal static string ProcessDidNotExitInTime {
            get {
                return ResourceManager.GetString("ProcessDidNotExitInTime", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {0} took too long to respond. The process exit code is {1}. Arguments: {2}.
        /// </summary>
        internal static string ProcessDidNotExitInTimeWithArguments {
            get {
                return ResourceManager.GetString("ProcessDidNotExitInTimeWithArguments", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Running {fileName} with parameters: &apos;{args}&apos;..
        /// </summary>
        internal static string RunningCli {
            get {
                return ResourceManager.GetString("RunningCli", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Rebuilding container {ContainerFilePath} from {DirectoryPath}..
        /// </summary>
        internal static string SavingContainer {
            get {
                return ResourceManager.GetString("SavingContainer", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to SignAsync called for {filePath}. Using {localFilePath} locally..
        /// </summary>
        internal static string SignAsyncCalled {
            get {
                return ResourceManager.GetString("SignAsyncCalled", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Performing attempt #{attempt} of {maxAttempts} attempts after {seconds} s..
        /// </summary>
        internal static string SigningAttempt {
            get {
                return ResourceManager.GetString("SigningAttempt", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Could not sign {0}..
        /// </summary>
        internal static string SigningFailed {
            get {
                return ResourceManager.GetString("SigningFailed", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Failed to sign. Attempts exceeded..
        /// </summary>
        internal static string SigningFailedAfterAllAttempts {
            get {
                return ResourceManager.GetString("SigningFailedAfterAllAttempts", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Signing failed with error {errorCode}..
        /// </summary>
        internal static string SigningFailedWithError {
            get {
                return ResourceManager.GetString("SigningFailedWithError", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Signing {filePath}..
        /// </summary>
        internal static string SigningFile {
            get {
                return ResourceManager.GetString("SigningFile", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Signing succeeded..
        /// </summary>
        internal static string SigningSucceeded {
            get {
                return ResourceManager.GetString("SigningSucceeded", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Completed in {millseconds} ms..
        /// </summary>
        internal static string SigningSucceededWithTimeElapsed {
            get {
                return ResourceManager.GetString("SigningSucceededWithTimeElapsed", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Submitting {filePath} for signing..
        /// </summary>
        internal static string SubmittingFileForSigning {
            get {
                return ResourceManager.GetString("SubmittingFileForSigning", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to The value cannot be an empty string..
        /// </summary>
        internal static string ValueCannotBeEmptyString {
            get {
                return ResourceManager.GetString("ValueCannotBeEmptyString", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Signing OpenVsixSignTool job with {count} files..
        /// </summary>
        internal static string VsixSignatureProviderSigning {
            get {
                return ResourceManager.GetString("VsixSignatureProviderSigning", resourceCulture);
            }
        }
    }
}
