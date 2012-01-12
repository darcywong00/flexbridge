﻿using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Linq;
using FLEx_ChorusPlugin.Infrastructure;
using FLEx_ChorusPlugin.Infrastructure.DomainServices;

/*
BC 1. ScrRefSystem (no owner)
	Books prop owns seq of ScrBookRef (which has all basic props).
	No other props.
	[Put all in one file in a subfolder of Scripture?]
*/
namespace FLEx_ChorusPlugin.Contexts.Scripture
{
	internal static class ScriptureReferenceSystemBoundedContextService
	{
		internal static void NestContext(XmlReaderSettings readerSettings, string baseDirectory,
			IDictionary<string, SortedDictionary<string, XElement>> classData,
			Dictionary<string, string> guidToClassMapping,
			Dictionary<string, Dictionary<string, HashSet<string>>> interestingPropertiesCache,
			HashSet<string> skipWriteEmptyClassFiles)
		{
			SortedDictionary<string, XElement> sortedInstanceData;
			if (!classData.TryGetValue("ScrRefSystem", out sortedInstanceData))
				return;
			if (sortedInstanceData.Count == 0)
				return;

			if (!Directory.Exists(baseDirectory))
				Directory.CreateDirectory(baseDirectory);

			var refSystem = sortedInstanceData.First().Value;

			CmObjectNestingService.NestObject(refSystem,
				new Dictionary<string, HashSet<string>>(),
				classData,
				interestingPropertiesCache,
				guidToClassMapping);

			var doc = new XDocument(new XDeclaration("1.0", "utf-8", "yes"),
				new XElement(SharedConstants.ScriptureReferenceSystem, refSystem));

			FileWriterService.WriteNestedFile(Path.Combine(baseDirectory, "srs." + SharedConstants.ScriptureReferenceSystem), readerSettings, doc);

			ObjectFinderServices.ProcessLists(classData, skipWriteEmptyClassFiles, new HashSet<string> { "ScrRefSystem", "ScrBookRef" });
		}

		internal static void FlattenContext(
			SortedDictionary<string, XElement> highLevelData,
			SortedDictionary<string, XElement> sortedData,
			Dictionary<string, Dictionary<string, HashSet<string>>> interestingPropertiesCache,
			string scriptureBaseDir)
		{
			if (!Directory.Exists(scriptureBaseDir))
				return; // Nothing to do.

			var doc = XDocument.Load(Path.Combine(scriptureBaseDir, "srs." + SharedConstants.ScriptureReferenceSystem));
			CmObjectFlatteningService.FlattenObject(sortedData,
				interestingPropertiesCache,
				doc.Element(SharedConstants.ScriptureReferenceSystem).Element("ScrRefSystem"),
				null); // Not owned.
		}

		internal static void RemoveBoundedContextData(string scriptureBaseDir)
		{
			if (!Directory.Exists(scriptureBaseDir))
				return;

			const string refSysPathname = "srs." + SharedConstants.ScriptureReferenceSystem;
			if (File.Exists(refSysPathname))
				File.Delete(refSysPathname);

			FileWriterService.RemoveEmptyFolders(scriptureBaseDir, true);
		}
	}
}