# csproj-nuget-template.md

**Version**: v1.0 – December 29, 2025  
**Build Tag**: 1.0.25363.1  
**Purpose**: Standard template for C# library csproj files, optimized for multi-targeting, NuGet packaging, and public domain sharing. Use in Plan/Implement phases of MacroFlow for new libs.

## Usage Notes

- Copy-paste this XML into your .csproj, replacing placeholders (e.g., {PackageId}, {TargetFrameworks}).
- Enables GeneratePackageOnBuild=true for auto .nupkg on dotnet pack.
- Multi-target for compat (net9.0 down to net472); conditionals for framework-specific deps like EFCore.
- Set GenerateDocumentationFile=true for XML docs in NuGet.
- Version via GetDayOfYear.ps1: Major.Minor.YYDDD.Increment.
- Push to GitHub with MIT license for public domain.

## Template csproj

```xml
<Project Sdk="Microsoft.NET.Sdk">

  <!-- Project Properties -->
  <PropertyGroup>
    <ApplicationIcon>Resources\Acornsoft.ico</ApplicationIcon>
    <AssemblyName>{AssemblyName}</AssemblyName>
    <Authors>David Blaszyk</Authors>
    <Company>{Company}</Company>
    <Copyright>Copyright © 2025</Copyright>
    <Description>{Description}</Description>
    <Deterministic>False</Deterministic>
    <EnableDefaultCompileItems>false</EnableDefaultCompileItems>
    <FileVersion>1.0.25363.1</FileVersion>
    <GenerateDocumentationFile>true</GenerateDocumentationFile> <!-- Enables XML docs in NuGet -->
    <GeneratePackageOnBuild>true</GeneratePackageOnBuild>
    <IconUrl>https://example.com/images/Icon.ico</IconUrl>
    <IsTestProject>false</IsTestProject>
    <PackageId>{PackageId}</PackageId> <!-- e.g., Company.Domain.Common -->
    <PackageLicenseExpression>MIT</PackageLicenseExpression>
    <PackageProjectUrl>https://example.sharepoint.com</PackageProjectUrl>
    <PackageRequireLicenseAcceptance>false</PackageRequireLicenseAcceptance>
    <RepositoryType>git</RepositoryType>
    <RepositoryUrl>{RepositoryUrl}</RepositoryUrl> <!-- e.g., https://github.com/acornsoft/domain-common -->
    <RootNamespace>{RootNamespace}</RootNamespace>
    <TargetFrameworks>{TargetFrameworks}</TargetFrameworks> <!-- e.g., net9.0;net8.0;net7.0;net6.0;net5.0;net48;net472 -->
    <Title>{Title}</Title>
    <Version>$(FileVersion)</Version>
  </PropertyGroup>

  <!-- Conditional Nullable and Language Version Settings -->
  <PropertyGroup Condition="'$$   (TargetFramework)' == 'net40' OR '   $$(TargetFramework)' == 'net472'">
    <LangVersion>7.3</LangVersion>
    <Nullable>disable</Nullable>
  </PropertyGroup>

  <!-- Common Compile Items and Project References -->
  <ItemGroup>
    <!-- Add your Compile includes here, e.g., -->
    <Compile Include="Logging\Interfaces\ILoggingAdapter.cs" />
    <!-- ... full list ... -->
  </ItemGroup>

  <!-- Common Package References (centralized where versions align) -->
  <ItemGroup>
    <!-- Add shared packs, e.g., -->
    <PackageReference Include="Bogus" Version="34.0.2" />
    <!-- ... -->
  </ItemGroup>