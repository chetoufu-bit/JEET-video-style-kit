import importlib.util
import json
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location("dsh_manager", ROOT / "scripts" / "dsh_manager.py")
assert SPEC and SPEC.loader
dsh_manager = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(dsh_manager)


class DshPackageTests(unittest.TestCase):
    def test_manifest_and_frontmatter(self):
        manifest = dsh_manager.load_manifest(ROOT)
        self.assertEqual(manifest["name"], "video-shotcraft")
        self.assertEqual(dsh_manager.validate_source(ROOT, manifest), [])
        text = (ROOT / "SKILL.md").read_text(encoding="utf-8").split("---", 2)[1]
        self.assertIn("user-invocable: true", text)
        self.assertIn("compatibility: native", text)

    def test_install_update_doctor_and_uninstall(self):
        with tempfile.TemporaryDirectory() as directory:
            home = Path(directory)
            first = dsh_manager.install(ROOT, home)
            self.assertEqual(first["action"], "installed")
            report = dsh_manager.doctor(ROOT, home)
            self.assertTrue(report["ok"], report)
            second = dsh_manager.install(ROOT, home)
            self.assertEqual(second["action"], "updated")
            removed = dsh_manager.uninstall(ROOT, home)
            self.assertEqual(removed["action"], "removed")

    def test_collision_is_preserved_and_force_creates_backup(self):
        with tempfile.TemporaryDirectory() as directory:
            home = Path(directory)
            target = home / "skills" / "video-shotcraft"
            target.mkdir(parents=True)
            (target / "user.txt").write_text("keep", encoding="utf-8")
            with self.assertRaises(dsh_manager.PackageError):
                dsh_manager.install(ROOT, home)
            result = dsh_manager.install(ROOT, home, force=True)
            self.assertEqual(result["action"], "backed-up-and-installed")
            self.assertEqual((Path(result["backup"]) / "user.txt").read_text(encoding="utf-8"), "keep")

    def test_gallery_index_and_template_manifest(self):
        library = json.loads((ROOT / "gallery" / "api" / "library.json").read_text(encoding="utf-8"))
        package = json.loads((ROOT / "template" / "package.json").read_text(encoding="utf-8"))
        self.assertEqual(library["stats"]["cardCount"], len(library["cards"]))
        self.assertIn("remotion", package["dependencies"])
        self.assertIn("render", package["scripts"])


if __name__ == "__main__":
    unittest.main()
